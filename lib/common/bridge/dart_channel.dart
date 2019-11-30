import 'dart:ui';

import 'package:flutter/services.dart';

typedef DartToNativeCallback = void Function(dynamic result);
typedef Future<dynamic> MethodHandler(MethodCall call);

class DartChannel {
  final _methodChannel = const MethodChannel('aeyepetizer_channel');
  final Set<MethodHandler> _methodHandlers = Set();

  DartChannel() {
    _methodChannel.setMethodCallHandler((MethodCall call) {
      for (MethodHandler handler in _methodHandlers) {
        handler(call);
      }

      return Future.value();
    });
  }

  Future<T> invokeMethod<T>(String method,
      {Map args, DartToNativeCallback callback}) async {
    dynamic result;
    if (args == null) {
      result = await _methodChannel.invokeMethod<T>(method);
    } else {
      result = await _methodChannel.invokeMethod<T>(method, args);
    }
    if (callback != null) {
      callback(result);
    }
    return result;
  }

  Future<List<T>> invokeListMethod<T>(String method,
      [dynamic arguments]) async {
    return _methodChannel.invokeListMethod<T>(method, arguments);
  }

  Future<Map<K, V>> invokeMapMethod<K, V>(String method,
      [dynamic arguments]) async {
    return _methodChannel.invokeMapMethod<K, V>(method, arguments);
  }

  VoidCallback addMethodHandler(MethodHandler handler) {
    assert(handler != null);

    _methodHandlers.add(handler);

    return () {
      _methodHandlers.remove(handler);
    };
  }

  static const NATIVE_REQUEST = "native_channel";
}
