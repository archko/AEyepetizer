import 'package:aeyepetizer/demo/CounterController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Demo2 extends StatelessWidget {
  const Demo2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// 通过依赖注入方式实例化的控制器
    final counter = Get.put(CounterController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("GetX"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
                  "count的值为：${counter.count}",
                  style: const TextStyle(color: Colors.redAccent, fontSize: 20),
                )),
            /*
            GetX<CounterController>(
              init: counter,
              builder: (controller){
                return Text(
                  "count的值为：${controller.count}",
                  style: const TextStyle(color: Colors.redAccent,fontSize: 20),
                );
              },
            ),
            */
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              // 按钮点击count值++
              onPressed: () => counter.increase(),
              child: const Text("点击count++"),
            ),
          ],
        ),
      ),
    );
  }
}
