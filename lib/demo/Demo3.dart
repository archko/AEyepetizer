import 'package:aeyepetizer/demo/CounterController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Demo3 extends StatelessWidget {
  const Demo3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CounterController());

    /// 上行代码已经将CounterController实例化，可以通过Get.find获取
    final state = Get.find<CounterController>().state;

    return Scaffold(
      appBar: AppBar(
        title: const Text("架构重构"),
      ),
      body: Center(
        child: GetBuilder<CounterController>(
          builder: (controller) {
            return Text("counter点击了${state.count}次");
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.increase2();
          },
          child: const Icon(Icons.arrow_forward_outlined)),
    );
  }
}
