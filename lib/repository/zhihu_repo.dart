import 'dart:async';

import 'package:aeyepetizer/common/http/web_config.dart';
import 'package:aeyepetizer/entity/zhihu_bean.dart';
import 'package:flutter_base/http/http_client.dart';
import 'package:flutter_base/http/http_response.dart';
import 'package:flutter_base/utils/isolate_utils.dart';
import 'package:flutter_base/utils/json_utils.dart';

class ZhihuRepo {
  static final ZhihuRepo _instance = ZhihuRepo();

  static ZhihuRepo get singleton => _instance;

  Future<ZhihuBean?> loadZhihuRecents() async {
    ZhihuBean? zhihuBean;
    try {
      Map<String, dynamic> args = Map();

      HttpResponse httpResponse =
          await HttpClient.instance.get(WebConfig.zhihuHot, params: args);

      zhihuBean = await run<ZhihuBean, String>(
          decodeZhihuBean, httpResponse.data as String);
    } catch (e) {
      print(e);
    }
    return zhihuBean;
  }

  static ZhihuBean decodeZhihuBean(String result) {
    var results = JsonUtils.decodeAsMap(result);
    return ZhihuBean.fromJson(results);
  }
}
