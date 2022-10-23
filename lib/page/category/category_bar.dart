import 'package:aeyepetizer/entity/acategory.dart';
import 'package:aeyepetizer/model/provider/category_controller.dart';
import 'package:aeyepetizer/page/video/video_by_category_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/widget/banner/custom_banner.dart';
import 'package:get/get.dart';

class CategoryBar extends StatefulWidget {
  CategoryBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CategoryBarState();
  }

  @override
  String toStringShort() {
    return "";
  }
}

class _CategoryBarState extends State<CategoryBar>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late CategoryController _categoryController;

  @override
  void initState() {
    super.initState();
    _categoryController = CategoryController();
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
          return _bar(context);
        });
  }

  Widget _bar(BuildContext context) {
    Widget widget;
    if (null == _categoryController.banners ||
        _categoryController.banners!.length == 0) {
      widget = Center(
        child: CircularProgressIndicator(),
      );
    } else {
      var banners = _categoryController.banners!;
      widget = CustomBanner(
        banners: banners,
        onTap: (int index) {
          _renderItem(context, index, _categoryController.data![index]);
        },
      );
    }
    return SliverAppBar(
      centerTitle: true,
      expandedHeight: 200.0,
      pinned: true,
      floating: false,
      snap: false,
      primary: true,
      //backgroundColor: Theme.of(context).backgroundColor,
      //backgroundColor: Color(0xFF303030),
      elevation: .0,
      forceElevated: true,
      title: Text("目录"),
      //leading: Icon(Icons.arrow_back),
      iconTheme: IconThemeData(color: Color(0xFFD8D8D8)),
      actions: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.only(top: 17, right: 15.0),
            child: Text("关于"),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: widget,
        ),
        centerTitle: true,
        collapseMode: CollapseMode.pin,
        stretchModes: [StretchMode.fadeTitle],
      ),
      toolbarTextStyle: TextTheme(
              subtitle1: TextStyle(fontSize: 17.0, color: Color(0xFFFFFFFF)))
          .bodyText2,
      titleTextStyle: TextTheme(
              subtitle1: TextStyle(fontSize: 17.0, color: Color(0xFFFFFFFF)))
          .headline6,
    );
  }

  _renderItem(context, index, ACategory item) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return VideoByCategoryPage(
            category: item,
          );
        },
      ),
    );
  }
}
