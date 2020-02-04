import 'package:aeyepetizer/common/http/header_interceptor.dart';
import 'package:aeyepetizer/common/http/web_config.dart';
import 'package:aeyepetizer/entity/acategory.dart';
import 'package:flutter_base/http/http_client.dart';
import 'package:flutter_base/http/http_response.dart';
import 'package:flutter_base/model/base_list_view_model.dart';
import 'package:flutter_base/utils/isolate_utils.dart';
import 'package:flutter_base/utils/json_utils.dart';

class CategoryViewModel extends BaseListViewModel {
  Future<List<ACategory>> loadData(int pn) async {
    List<ACategory> list;
    try {
      Map<String, dynamic> args = Map();
      args['udid'] = 'd2807c895f0348a180148c9dfa6f2feeac0781b5';
      args['deviceModel'] = 'vivo x21';

      HttpResponse httpResponse = await HttpClient.instance
          .get(WebConfig.categoriesUrl, params: args);
      print("result:${httpResponse.data}");
      final lb = await loadBalancer;
      list = await lb.run<List<ACategory>, String>(
          decodeListResult, httpResponse.data as String);
    } catch (e) {
      print(e);
      list = [];
    }
    return list;
  }

  Future<List<ACategory>> loadMore(int pn) async {
    return loadData(pn);
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
