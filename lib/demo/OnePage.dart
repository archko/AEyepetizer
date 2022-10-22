import 'package:aeyepetizer/demo/CounterController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnePage extends GetView<CounterController> {
  const OnePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CounterController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("GetView"),
      ),
      body: Center(
        child: GetBuilder<CounterController>(
          builder: (controller) {
            return Text("点击了${controller.count}次");
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.increase2();
          },
          child: const Icon(Icons.add)),
    );
  }
}
