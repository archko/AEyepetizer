import 'package:aeyepetizer/page/category/category_page.dart';
import 'package:aeyepetizer/page/movie/movie_list_page.dart';
import 'package:aeyepetizer/widget/tabs/gsy_tab_bar_widget.dart';
import 'package:flutter/material.dart';

class TabBarPageWidget extends StatefulWidget {
  final String title;

  const TabBarPageWidget({Key key, this.title}) : super(key: key);

  @override
  _TabBarPageWidgetState createState() => _TabBarPageWidgetState();
}

class _TabBarPageWidgetState extends State<TabBarPageWidget> {
  final PageController pageControl = new PageController();

  final List<String> tabs = ["first", "second", "third", "fouth"];
  final List<Widget> tabViews = [
    CategoryPage(),
    MovieListPage(),
  ];

  _renderTab() {
    List<Widget> list = new List();
    for (int i = 0; i < tabViews.length; i++) {
      list.add(new FlatButton(
          onPressed: () {
            pageControl.jumpTo(MediaQuery.of(context).size.width * i);
          },
          child: new Text(
            tabViews[i].toStringShort(),
            maxLines: 1,
          )));
    }
    return list;
  }

  _renderPage() {
    return tabViews;
  }

  @override
  Widget build(BuildContext context) {
    return new GSYTabBarWidget(
        type: GSYTabBarWidget.TOP_TAB,
        tabItems: _renderTab(),
        tabViews: _renderPage(),
        pageControl: pageControl,
        backgroundColor: Colors.lightBlue,
        indicatorColor: Colors.white,
        title: new Text(widget.title == null ? "" : widget.title));
  }
}
