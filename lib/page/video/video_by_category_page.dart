import 'package:aeyepetizer/entity/acategory.dart';
import 'package:aeyepetizer/entity/trending.dart';
import 'package:aeyepetizer/entity/video_item.dart';
import 'package:aeyepetizer/model/video_by_category_view_model.dart';
import 'package:aeyepetizer/page/video/video_detail_list_page.dart';
import 'package:aeyepetizer/page/video/video_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/model/base_list_state.dart';
import 'package:flutter_base/utils/string_utils.dart';
import 'package:flutter_base/widget/list/pull_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VideoByCategoryPage extends StatefulWidget {
  VideoByCategoryPage({Key key, this.category}) : super(key: key);
  final ACategory category;

  @override
  State<StatefulWidget> createState() {
    return _VideoByCategoryPageState();
  }
}

class _VideoByCategoryPageState extends State<VideoByCategoryPage>
    with BaseListState<VideoByCategoryPage>, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    refreshController = new RefreshController(initialRefresh: true);
    viewModel = new VideoByCategoryViewModel();
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  Future refresh() async {
    viewModel.setPage(startPage);
    await (viewModel as VideoByCategoryViewModel)
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
    if (viewModel.getCount() < 1) {
      return refresh();
    }
    VideoByCategoryViewModel cViewModel = (viewModel as VideoByCategoryViewModel);
    Trending trendingb = cViewModel.last;
    if (trendingb == null || StringUtils.isEmpty(trendingb.nextPageUrl)) {
      refreshController.loadNoData();
      return null;
    }
    await cViewModel.loadMore(-1).then((trending) {
      cViewModel.updateDataAndPage(trending.itemList, viewModel.page + 1);
      setState(() {
        if (trending.itemList == null || trending.itemList.length < 1) {
          refreshController.loadNoData();
        } else {
          refreshController.refreshCompleted(resetFooterState: true);
        }
        print(
            "loadMore end.${refreshController.footerStatus},${viewModel.page}, ${viewModel.getCount()}");
      });
    }).catchError((e) => setState(() {
          print("loadMore error:$e");
          refreshController.loadFailed();
        }));
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
        onLoadMore: loadMore,
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
              return new VideoDetailListPage(
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
