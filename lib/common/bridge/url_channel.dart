import 'dart:collection';

import 'flutter_bridge.dart';

class UrlChannel {
  static Future<dynamic> get({Map args}) async {
    args ?? HashMap();
    return FlutterMain.singleton.channel.invokeMethod(_URL_CHANNEL, args);
  }

  static const _URL_CHANNEL = "url_channel";

  static const String URL_CATEGORY = "category";
  static const String URL_CATEGORY_BY_ID = "category_by_id";
}
