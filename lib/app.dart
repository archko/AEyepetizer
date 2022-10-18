import 'dart:io';

import 'package:aeyepetizer/page/home/test_tabs_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/http/http_client.dart';
import 'package:flutter_base/http/interceptor/http_header_interceptor.dart';
import 'package:flutter_base/http/interceptor/http_log_interceptor.dart';
import 'package:flutter_base/log/logger.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

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
  HttpClient.instance.addInterceptor(HttpHeaderInterceptor());
  HttpClient.instance.addInterceptor(HttpLogInterceptor());
  return GetMaterialApp(home: StateDemoApp());
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
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        //body: HomeTabsPage(),
        body: TestTabsPage(),
        //body: NewsPage(),
        //body: WallpaperPage(),
      ),
    );
  }
}
