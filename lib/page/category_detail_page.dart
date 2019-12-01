import 'package:aeyepetizer/entity/acategory.dart';
import 'package:aeyepetizer/entity/video_item.dart';
import 'package:aeyepetizer/model/category_detail_view_model.dart';
import 'package:aeyepetizer/page/base_list_state.dart';
import 'package:aeyepetizer/page/video_list_item.dart';
import 'package:aeyepetizer/page/video_page.dart';
import 'package:aeyepetizer/widget/list/pull_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryDetailPage extends StatefulWidget {
  CategoryDetailPage({Key key, this.category}) : super(key: key);
  final ACategory category;

  @override
  State<StatefulWidget> createState() {
    return _CategoryDetailPageState();
  }
}

class _CategoryDetailPageState extends State<CategoryDetailPage>
    with BaseListState<CategoryDetailPage>, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    refreshController = new RefreshController(initialRefresh: true);
    viewModel = new CategoryDetailViewModel();
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  Future refresh() async {
    viewModel.setPage(startPage);
    await (viewModel as CategoryDetailViewModel)
        .loadData(viewModel.page, widget.category)
        .then((trending) {
      viewModel.setData(trending.itemList);
      setState(() {
        print("refresh end.${viewModel.page}, ${viewModel.getCount()}");
        if (trending.itemList == null || trending.itemList.length < 1) {
          refreshController.loadNoData();
        } else {
          refreshController.refreshCompleted(resetFooterState: true);
        }
      });
    }).catchError((e) => setState(() {
              print("refresh error,$e");
              refreshController.loadFailed();
            }));
  }

  @override
  Future<void> loadMore() async {
    refreshController.loadNoData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
      ),
      body: PullWidget(
        pullController: refreshController,
        listCount: viewModel.getCount(),
        itemBuilder: (BuildContext context, int index) =>
            _renderItem(context, index),
        header: MaterialClassicHeader(),
        footer: ClassicFooter(
          loadStyle: LoadStyle.HideAlways,
        ),
        //onLoadMore: loadMore,
        onRefresh: refresh,
      ),
    );
  }

  //列表的ltem
  _renderItem(context, index) {
    var item = viewModel.data[index] as VideoItem;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          new MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return new VideoDemo(
                videoData: item.data,
              );
            },
          ),
        );
      },
      child: VideoListItem(bean: item),
    );
  }
}
