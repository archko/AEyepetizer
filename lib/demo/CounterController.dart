import 'package:aeyepetizer/demo/CounterState.dart';
import 'package:dio/dio.dart';
import 'package:flutter_base/http/http_client.dart';
import 'package:flutter_base/http/http_response.dart';
import 'package:flutter_base/log/logger.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart';

class CounterController extends GetxController {
  /// 定义了该变量为响应式变量，当该变量数值变化时，页面的刷新方法将自动刷新
  var count = 0;

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

  Future<Map<String, dynamic>?> getToken() async {
    Map<String, dynamic>? result;
    try {
      Map<String, dynamic> header = Map();
      header['content-type'] = "application/x-www-form-urlencoded";
      var url = "https://api.cnblogs.com/token";
      
      Map<String, dynamic> args = Map();
      args['client_id'] = "1206278b-183a-4693-8cc9-acc2628306f6";
      args['client_secret'] = "f-Nt_OnnFwJtywfgZ5_-JOr9O46VFZB8UfTWLgDfNi6kaB5hclaAGiRhg-M33nglndS_2wYRh3qAJC-s";
      args['grant_type'] = "client_credentials";

      HttpResponse httpResponse =
          await HttpClient.instance.post(url, header: header, data: args);
      String string = httpResponse.data as String;
      Logger.d("result:$string");
    } catch (e) {
      print(e);
    }
    return result;
  }
}
