import 'dart:collection';

import 'package:aeyepetizer/common/bridge/flutter_bridge.dart';

class UrlChannel {
  static Future<dynamic> get({Map args}) async {
    args ?? HashMap();
    return FlutterMain.singleton.channel.invokeMethod(_URL_CHANNEL, args);
  }

  static const _URL_CHANNEL = "url_channel";

  static const String URL_CATEGORY = "category";
  static const String URL_CATEGORY_BY_ID = "category_by_id";
  static const String URL_VIDEO_BY_ID = "video_by_id";
  static const String URL_HOT_WEEKLY = "hot_weekly";
  static const String URL_HOT_MONTHLY = "hot_monthly";
  static const String URL_TOTAL_RANKING = "total_ranking";
}
