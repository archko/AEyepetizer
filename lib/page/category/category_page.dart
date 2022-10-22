import 'package:aeyepetizer/model/provider/category_controller.dart';
import 'package:aeyepetizer/page/category/category_item.dart';
import 'package:aeyepetizer/page/video/video_by_category_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key? key}) : super(key: key);

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
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late RefreshController _refreshController;
  late CategoryController _categoryController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: true);
    _categoryController =
        CategoryController(refreshController: _refreshController);
  }

  @override
  void dispose() {
    super.dispose();
    print("$this,dispose");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<CategoryController>(
        init: _categoryController,
        initState: (data) => _categoryController.refreshList(),
        builder: (controller) {
          if (_categoryController.getCount() < 1) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
              margin: EdgeInsets.all(4),
              child: SmartRefresher(
                physics: BouncingScrollPhysics(),
                enablePullDown: true,
                enablePullUp: false,
                controller: _refreshController,
                onRefresh: _categoryController.refreshList,
                //onLoading: model.loadMore,
                header: MaterialClassicHeader(),
                footer: ClassicFooter(
                  loadStyle: LoadStyle.HideAlways,
                ),
                //child: GridView.builder(
                //  physics: BouncingScrollPhysics(),
                //  primary: false,
                //  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //      crossAxisCount: 2,
                //      crossAxisSpacing: 4,
                //      mainAxisSpacing: 4,
                //      childAspectRatio: 1),
                //  itemCount: model.getCount(),
                //  itemBuilder: (BuildContext context, int index) =>
                //      _renderItem(context, index, model),
                //),
                child: ListView.builder(
                  itemCount: _categoryController.getCount(),
                  itemBuilder: (BuildContext context, int index) =>
                      _renderItem(context, index, _categoryController),
                ),
              ),
            );
          }
        });
  }

//列表的ltem
  _renderItem(context, index, model) {
    var item = model.data[index];
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
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
