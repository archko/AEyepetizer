import 'package:aeyepetizer/model/app_provider.dart';
import 'package:aeyepetizer/widget/tabs/tab_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  //runApp(StateDemoApp());
  runApp(_widgetForRoute(window.defaultRouteName));
}

Widget _widgetForRoute(String route) {
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

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => AppProvider()),
      ],
      child: Consumer<AppProvider>(
        builder: (context, counter, _) {
          return MaterialApp(
            title: 'Funny Clips',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            //home: TestProviderPage(),
            home: TabBarPageWidget(),
          );
        },
      ),
    );
  }
}
