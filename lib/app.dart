import 'dart:io';

import 'package:aeyepetizer/demo/Demo1.dart';
import 'package:aeyepetizer/page/home/test_tabs_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/http/http_client.dart';
import 'package:flutter_base/http/interceptor/http_header_interceptor.dart';
import 'package:flutter_base/http/interceptor/http_log_interceptor.dart';
import 'package:flutter_base/log/logger.dart';
import 'package:get/get.dart';

Widget createApp() {
  if (Platform.isAndroid) {
    SystemUiOverlayStyle style = SystemUiOverlayStyle(
      ///这是设置状态栏的图标和字体的颜色
      ///Brightness.light  一般都是显示为白色
      ///Brightness.dark 一般都是显示为黑色
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF000000),
      systemNavigationBarDividerColor: null,

      /// 注意安卓要想实现沉浸式的状态栏 需要底部设置透明色
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    );
    SystemChrome.setSystemUIOverlayStyle(style);
  }
  Logger.init(debuggable: true);
  //HttpClient.instance.addInterceptor(HttpHeaderInterceptor());
  //HttpClient.instance.addInterceptor(HttpLogInterceptor());
  return MaterialApp(home: StateDemoApp());
}

class StateDemoApp extends StatefulWidget {
  const StateDemoApp({
    Key? key,
  }) : super(key: key);

  @override
  _StateDemoAppState createState() => _StateDemoAppState();
}

class _StateDemoAppState extends State<StateDemoApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.changeTheme(appLightThemeData);
    return GetMaterialApp(
      /*theme: ThemeData(
        primarySwatch: Colors.green,
      ),*/
      home: Scaffold(
        //body: HomeTabsPage(),
        body: TestTabsPage(),
      ),
    );
  }
}

final ThemeData appDarkThemeData = ThemeData(
  brightness: Brightness.dark,
  /*primaryColor: Colors.red,
  // 主要部分背景颜色（导航和tabBar等）
  scaffoldBackgroundColor: Colors.red,
  //Scaffold的背景颜色。典型Material应用程序或应用程序内页面的背景颜色
  textTheme:
      TextTheme(headline1: TextStyle(color: Colors.yellow, fontSize: 15)),
  appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.yellow)),*/
);

//创建light ThemeData对象
final ThemeData appLightThemeData = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  // 主要部分背景颜色（导航和tabBar等）
  /*scaffoldBackgroundColor: Colors.white,
  //Scaffold的背景颜色。典型Material应用程序或应用程序内页面的背景颜色
  textTheme: TextTheme(headline1: TextStyle(color: Colors.blue, fontSize: 15)),
  appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: Colors.black)),*/
);
