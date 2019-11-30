import 'dart:collection';

import 'flutter_bridge.dart';
import 'dart_channel.dart';

class UrlChannel {
  static Future<dynamic> get({Map args, DartToNativeCallback callback}) async {
    args ?? HashMap();
    FlutterMain.singleton.channel
        .invokeMethod(_HTTP_CHANNEL, args: args, callback: callback);
  }

  static const _HTTP_CHANNEL = "url_channel";

  static const String URL_CATEGORY = "category";
}
