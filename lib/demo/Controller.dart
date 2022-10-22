import 'package:get/get.dart';

class Controller extends GetxController {
  var name = "".obs;
  var age = 18.obs;

  @override
  void onInit() {
    /// 每次`name`变化时调用。
    ever(name, (callback) => null);

    /// 每次监听多个值变化时调用。
    everAll([name, age], (callback) => null);

    /// 只有在变量第一次被改变时才会被调用
    once(name, (callback) => null);

    /// 场景：变量频繁改变，如果用户多次输入、多次点击等。 防DDos - 当变量停止变化1秒后调用，
    /// 例如：搜索功能。用户输入完整单词后再执行搜索操作，而不是用户每输入一个字符就要进行一次操作
    debounce(name, (callback) => null, time: const Duration(seconds: 1));

    /// 忽略指定时间内变量的所有变化
    interval(name, (callback) => null, time: const Duration(seconds: 1));

    super.onInit();
  }
}
