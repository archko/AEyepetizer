import 'package:aeyepetizer/demo/CounterState.dart';
import 'package:flutter_base/log/logger.dart';
import 'package:get/get.dart';

class CounterController extends GetxController {
  /// 定义了该变量为响应式变量，当该变量数值变化时，页面的刷新方法将自动刷新
  var count = 0.obs;

  /// 自增方法
  void increase() => ++count;

  @override
  void onInit() {
    super.onInit();
    Logger.d("onInit:$count");
    count++;
    add();
    update();
  }

  Future add() async {
    count++;
    Logger.d("add:$count");
  }

  /// 实例化状态类，以便操作所有的变量
  final CounterState state = CounterState();

  /// 自增方法
  void increase2() {
    state.count++;
    count++;
    update();
  }
}
