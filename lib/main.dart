import 'dart:ui';

import 'package:aeyepetizer/model/app_provider.dart';
import 'package:aeyepetizer/page/category/category_page.dart';
import 'package:aeyepetizer/page/hot/hot_video_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/widget/tabs/tab_bar_widget.dart';
import 'package:provider/provider.dart';

void main() {
  //runApp(StateDemoApp());
  runApp(_widgetForRoute(window.defaultRouteName));
}

Widget _widgetForRoute(String route) {
  print("route:$route");
  switch (route) {
    case 'home':
      return new StateDemoApp();
    default:
      return new StateDemoApp();
  }
}

class StateDemoApp extends StatefulWidget {
  const StateDemoApp({
    Key key,
  }) : super(key: key);

  @override
  _StateDemoAppState createState() => _StateDemoAppState();
}

class _StateDemoAppState extends State<StateDemoApp> {
  AppProvider model;

  @override
  void initState() {
    super.initState();
    model = AppProvider(); //..loadMovies();
  }

  final List<Widget> tabViews = [
    CategoryPage(),
    HotVideoListPage(
      type: HotVideoListPage.TYPE_HOT_WEEKLY,
    ),
    HotVideoListPage(
      type: HotVideoListPage.TYPE_HOT_MONTHLY,
    ),
    HotVideoListPage(
      type: HotVideoListPage.TYPE_TOTAL_RANKING,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => AppProvider()),
      ],
      child: Consumer<AppProvider>(
        builder: (context, counter, _) {
          return MaterialApp(
            title: 'AEyepetizer',
            theme: ThemeData(
              primarySwatch: Colors.red,
            ),
            home: TabBarPageWidget(
              tabViews: tabViews,
              title: "AEyepetizer",
            ),
          );
        },
      ),
    );
  }
}
