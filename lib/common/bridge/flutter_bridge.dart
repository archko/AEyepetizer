import 'package:aeyepetizer/common/bridge/dart_channel.dart';

class FlutterMain {
  static final FlutterMain _instance = FlutterMain();

  static FlutterMain get singleton => _instance;
  final DartChannel _dartToNative = DartChannel();

  DartChannel get channel => _dartToNative;
}
