import 'dart:async';
import 'dart:io';

import 'package:aeyepetizer/common/http/web_config.dart';
import 'package:aeyepetizer/entity/acategory.dart';
import 'package:aeyepetizer/entity/animate.dart';
import 'package:aeyepetizer/entity/gank_banner.dart';
import 'package:aeyepetizer/entity/gank_bean.dart';
import 'package:aeyepetizer/entity/gank_category.dart';
import 'package:aeyepetizer/entity/gank_response.dart';
import 'package:flutter_base/http/http_client.dart';
import 'package:flutter_base/http/http_response.dart';
import 'package:flutter_base/utils/isolate_utils.dart';
import 'package:flutter_base/utils/json_utils.dart';

class VideoRepository {
  static final VideoRepository _instance = VideoRepository();

  static VideoRepository get singleton => _instance;

  Future<List<ACategory>> loadData([int pn]) async {
    List<ACategory> list;
    try {
      Map<String, dynamic> args = Map();
      args['udid'] = 'd2807c895f0348a180148c9dfa6f2feeac0781b5';
      args['deviceModel'] = 'vivo x21';

      HttpResponse httpResponse =
          await HttpClient.instance.get(WebConfig.categoriesUrl, params: args);
      print("result:${httpResponse.data}");
      list = await loadWithBalancer<GankResponse<List<GankCategory>>, String>(
          decodeListResult, httpResponse.data as String);
    } catch (e) {
      print(e);
      list = [];
    }
    return list;
  }

  static List<ACategory> decodeListResult(String result) {
    var results = JsonUtils.decodeAsList(result);
    List<ACategory> beans = List();
    for (var item in results) {
      //print("item:$item,");
      beans.add(ACategory.fromJson(item));
    }
    return beans;
  }
}
