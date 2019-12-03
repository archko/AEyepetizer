import 'package:aeyepetizer/model/category_view_model.dart';
import 'package:aeyepetizer/page/list/base_list_state.dart';
import 'package:aeyepetizer/page/category/category_item.dart';
import 'package:aeyepetizer/page/video/video_by_category_page.dart';
import 'package:aeyepetizer/widget/list/pull_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CategoryPageState();
  }

  @override
  String toStringShort() {
    return "发现";
  }
}

class _CategoryPageState extends State<CategoryPage>
    with BaseListState<CategoryPage>, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    refreshController = RefreshController(initialRefresh: true);
    viewModel = CategoryViewModel();
  }

  @override
  void dispose() {
    super.dispose();
    print("$this,dispose");
  }

  Future<void> loadMore() async {
    refreshController.loadNoData();
  }

  @override
  Widget build(BuildContext context) {
    //return PullWidget(
    //  pullController: refreshController,
    //  listCount: viewModel.getCount(),
    //  itemBuilder: (BuildContext context, int index) =>
    //      _renderItem(context, index),
    //  header: MaterialClassicHeader(),
    //  footer: ClassicFooter(
    //    loadStyle: LoadStyle.HideAlways,
    //  ),
    //  //onLoadMore: loadMore,
    //  onRefresh: refresh,
    //);
    return Container(
      margin: EdgeInsets.all(4),
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        controller: refreshController,
        onRefresh: refresh,
        header: MaterialClassicHeader(),
        footer: ClassicFooter(
          loadStyle: LoadStyle.HideAlways,
        ),
        onLoading: loadMore,
        child: GridView.builder(
          primary: false,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              childAspectRatio: 1),
          itemCount: viewModel.getCount(),
          itemBuilder: (BuildContext context, int index) =>
              _renderItem(context, index),
        ),
      ),
    );
  }

  //列表的ltem
  _renderItem(context, index) {
    var item = viewModel.data[index];
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute<void>(
            builder: (BuildContext context) {
              return VideoByCategoryPage(
                category: item,
              );
            },
          ),
        );
      },
      child: CategoryItem(bean: item),
    );
  }
}
