import 'package:aeyepetizer/utils/string_utils.dart';

class Logger {
  static const String TAG_DEF = "eyepetizer";

  static bool isDebug = true;

  static void init({bool debuggable = true}) {
    isDebug = debuggable;
  }

  static void log(Object object, {String tag}) {
    if (isDebug) {
      printLog(tag, '  v  ', object);
    }
  }

  static void error(Object object, {String tag}) {
    printLog(tag, '  e  ', object);
  }

  static void printLog(String tag, String stag, Object object) {
    if (!StringUtils.isEmpty(tag)) {
      print(tag);
    }

    if (!isDebug) {
      return;
    }

    var tempData = object.toString();
    final int len = tempData.length;
    final int div = 1600;
    int count = len ~/ div;
    if (count > 0) {
      for (int i = 0; i < count; i++) {
        print(tempData.substring(i * div, (i + 1) * div));
      }
      int mode = len % div;
      if (mode > 0) {
        print(tempData.substring(div * count, len));
      }
    } else {
      print(tempData);
    }
  }
}
