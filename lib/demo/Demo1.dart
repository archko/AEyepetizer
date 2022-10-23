import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Demo1 extends StatelessWidget {
  Demo1({Key? key}) : super(key: key);

  /// 3种方式声明变量
  // RxInt count = RxInt(0);
  // var count = Rx<int>(0);
  var count = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              'https://img.zcool.cn/community/0372d195ac1cd55a8012062e3b16810.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0, //appbar阴影
          title: const Text("GetX"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 用Obx包装需要使用变量的widget
              Obx(() => Text(
                    "count的值为：$count",
                    style:
                        const TextStyle(color: Colors.redAccent, fontSize: 20),
                  )),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                // 按钮点击count值++
                onPressed: () => count++,
                child: const Text("点击count++"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
