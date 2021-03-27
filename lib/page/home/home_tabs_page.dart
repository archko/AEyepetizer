import 'package:aeyepetizer/entity/gank_banner.dart';
import 'package:aeyepetizer/entity/gank_category.dart';
import 'package:aeyepetizer/entity/gank_response.dart';
import 'package:aeyepetizer/model/provider/home_provider.dart';
import 'package:aeyepetizer/page/category/category_page.dart';
import 'package:aeyepetizer/page/list/gank_girl_list_page.dart';
import 'package:aeyepetizer/page/list/gank_list_page.dart';
import 'package:aeyepetizer/page/movie/movie_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/model/provider_widget.dart';
import 'package:flutter_base/utils/object_utils.dart';
import 'package:provider/provider.dart';

import 'package:flutter_base/widget/banner/custom_banner.dart';
import 'package:flutter_base/widget/tabs/tabs_widget.dart';

class HomeTabsPage extends StatefulWidget {
  HomeTabsPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeTabsPageState();
  }

  @override
  String toStringShort() {
    return '';
  }
}

class _HomeTabsPageState extends State<HomeTabsPage> {
  List<Widget> _defaultTabViews = [
    GankGirlListPage(
      category: GankCategory(type: "Girl"),
      categoryType: "Girl",
    ),
    CategoryPage(),
    MovieListPage(),
  ];
  List<TabItem> _defaultTabItems = <TabItem>[
    TabItem(text: 'GankGirl'),
    TabItem(text: '发现'),
    TabItem(text: 'Movie'),
  ];
  ShapeDecoration _decoration = ShapeDecoration(
    shape: StadiumBorder(
          side: BorderSide(
            color: Colors.white,
            width: 1.5,
          ),
        ) +
        const StadiumBorder(
          side: BorderSide(
            color: Colors.transparent,
            width: 1.5,
          ),
        ),
  );
  HomeProvider _homeProvider;
  String _categoryType = "Article";

  @override
  void initState() {
    super.initState();
    _homeProvider = HomeProvider(_categoryType);
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    ///轮播图高度
    double _swiperHeight = 200 + 10.0;

    ///提示头部高度
    double _spikeHeight = 80;

    ///_appBarHeight算的是AppBar的bottom高度，kToolbarHeight是APPBar高，statusBarHeight是状态栏高度
    double _appBarHeight =
        _swiperHeight + _spikeHeight - kToolbarHeight - statusBarHeight;

    return ProviderWidget<HomeProvider>(
      model: _homeProvider,
      onModelInitial: (m) {
        m.loadCategories();
        m.loadBanner();
      },
      /*builder: (context, model, childWidget) {
        return NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),

                ///SliverAppBar也可以实现吸附在顶部的TabBar，但是高度不好计算，总是会有AppBar的空白高度，
                ///所以我就用了SliverPersistentHeader来实现这个效果，SliverAppBar的bottom中只放TabBar顶部的布局
                child: _bar(context, model),
              ),

              ///停留在顶部的TabBar
              //SliverPersistentHeader(
              //  delegate: _SliverAppBarDelegate(_timeSelection()),
              //  pinned: true,
              //),
            ];
          },
          body: _buildBody(context, model),
        );
      },*/
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),

              ///SliverAppBar也可以实现吸附在顶部的TabBar，但是高度不好计算，总是会有AppBar的空白高度，
              ///所以我就用了SliverPersistentHeader来实现这个效果，SliverAppBar的bottom中只放TabBar顶部的布局
              sliver: Selector<HomeProvider, GankResponse<List<GankBanner>>>(
                builder: (_, GankResponse<List<GankBanner>> data, child) {
                  return _bar(context, _homeProvider);
                },
                selector: (_, HomeProvider homeProvider) {
                  return homeProvider.gankBannerResponse;
                },
                shouldRebuild: (GankResponse<List<GankBanner>> prev,
                    GankResponse<List<GankBanner>> now) {
                  return prev == null || prev.data != now.data;
                },
              ),
            ),

            ///停留在顶部的TabBar
            //SliverPersistentHeader(
            //  delegate: _SliverAppBarDelegate(_timeSelection()),
            //  pinned: true,
            //),
          ];
        },
        body: Selector<HomeProvider, List<GankCategory>>(
          builder: (_, List<GankCategory> data, child) {
            return _buildBody(context, _homeProvider);
          },
          selector: (_, HomeProvider homeProvider) {
            //这里需要处理空集,否则会有类型错误.
            return (ObjectUtils.isNull(homeProvider.data) ||
                    homeProvider.data.length == 0)
                ? List<GankCategory>()
                : homeProvider.data;
          },
          shouldRebuild: (List<GankCategory> prev, List<GankCategory> now) {
            return prev == null || prev != now;
          },
        ),
      ),
    );
  }

  Widget _bar(BuildContext context, HomeProvider model) {
    Widget widget;
    if (model.getBannerBeans() == null) {
      widget = Center(
        child: CircularProgressIndicator(),
      );
    } else {
      widget = CustomBanner(banners: model.getBannerBeans());
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
      elevation: 10.0,
      forceElevated: true,
      title: Text("干货"),
      //leading: Icon(Icons.arrow_back),
      iconTheme: IconThemeData(color: Color(0xFFD8D8D8)),
      textTheme:
          TextTheme(title: TextStyle(fontSize: 17.0, color: Color(0xFFFFFFFF))),
      actions: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.only(top: 17, right: 15.0),
            child: Text(""),
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
    );
  }

  Widget _buildBody(BuildContext context, HomeProvider model) {
    Widget content;
    if (model.loadStatus == 0) {
      content = Center(
        child: CircularProgressIndicator(),
      );
    } else if (model.loadStatus == 1) {
      content = _initTabs(model.data);
    } else {
      content = _buildDefaultTabs();
    }

    return content;
  }

  Widget _initTabs(List<GankCategory> list) {
    List<Widget> tabViews = [];
    List<TabItem> tabItems = [];
    bool hasGirl = false;
    for (GankCategory category in list) {
      if ("Girl" == category.title) {
        hasGirl = true;
        tabViews.add(
            GankGirlListPage(category: category, categoryType: _categoryType));
        tabItems.add(TabItem(text: category.title));
      } else {
        tabViews
            .add(GankListPage(category: category, categoryType: _categoryType));
        tabItems.add(TabItem(text: category.title));
      }
    }

    if (!hasGirl) {
      tabViews.insert(
          0,
          GankGirlListPage(
              category: GankCategory(title: "Girl"), categoryType: "Girl"));
      tabItems.insert(0, TabItem(text: 'Girl'));
      tabViews.insert(1, CategoryPage());
      tabItems.insert(1, TabItem(text: '发现'));
      tabViews.insert(2, MovieListPage());
      tabItems.insert(2, TabItem(text: 'Movie'));
    }

    return TabsWidget(
      tabsViewStyle: TabsViewStyle.noAppbarTopTab,
      tabStyle: TabsStyle.textOnly,
      tabViews: tabViews,
      tabItems: tabItems,
      isScrollable: true,
      customIndicator: false,
      decoration: _decoration,
      backgroundColor: Theme.of(context).accentColor,
      title: Text("干货"),
    );
  }

  Widget _buildDefaultTabs() {
    return TabsWidget(
      tabsViewStyle: TabsViewStyle.noAppbarTopTab,
      tabStyle: TabsStyle.textOnly,
      tabViews: _defaultTabViews,
      tabItems: _defaultTabItems,
      isScrollable: true,
      customIndicator: false,
      decoration: _decoration,
      backgroundColor: Theme.of(context).accentColor,
      title: Text("干货"),
    );
  }
}
