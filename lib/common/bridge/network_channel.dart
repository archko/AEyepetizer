import 'dart:collection';

import 'flutter_bridge.dart';
import 'dart_channel.dart';

class HttpChannel {
  static Future<dynamic> post({Map args}) async {
    args ?? HashMap();
    args['method'] = 'post';
    return FlutterMain.singleton.channel.invokeMethod(_HTTP_CHANNEL, args);
  }

  static Future<dynamic> get({Map args}) async {
    args ?? HashMap();
    args['method'] = 'get';
    return FlutterMain.singleton.channel.invokeMethod(_HTTP_CHANNEL, args);
  }

  static const _HTTP_CHANNEL = "http_channel";
}
