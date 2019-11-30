import 'dart:collection';

import 'flutter_bridge.dart';
import 'dart_channel.dart';

class NetworkChannel {
  static Future<dynamic> post({Map args, DartToNativeCallback callback}) async {
    args ?? HashMap();
    args['method'] = 'post';
    FlutterMain.singleton.channel
        .invokeMethod(_HTTP_CHANNEL, args: args, callback: callback);
  }

  static Future<dynamic> get({Map args, DartToNativeCallback callback}) async {
    args ?? HashMap();
    args['method'] = 'get';
    FlutterMain.singleton.channel
        .invokeMethod(_HTTP_CHANNEL, args: args, callback: callback);
  }

  static const _HTTP_CHANNEL = "http_channel";
}
