import 'package:aeyepetizer/model/category_view_model.dart';
import 'package:aeyepetizer/page/base_list_state.dart';
import 'package:aeyepetizer/page/category_item.dart';
import 'package:aeyepetizer/widget/list/pull_widget.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CategoryPageState();
  }
}

class _CategoryPageState extends State<CategoryPage>
    with BaseListState<CategoryPage>, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    refreshController = new RefreshController(initialRefresh: true);
    viewModel = new CategoryViewModel();
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    return PullWidget(
      pullController: refreshController,
      listCount: viewModel.getCount(),
      itemBuilder: (BuildContext context, int index) =>
          _renderItem(context, index),
      header: MaterialClassicHeader(),
      onLoadMore: loadMore,
      onRefresh: refresh,
    );
  }

  //列表的ltem
  _renderItem(context, index) {
    return CategoryItem(bean: viewModel.data[index]);
  }
}
