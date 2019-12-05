import 'package:aeyepetizer/common/bridge/url_channel.dart';
import 'package:aeyepetizer/common/http/http_client.dart';
import 'package:aeyepetizer/common/http/http_response.dart';
import 'package:aeyepetizer/common/isolate_utils.dart';
import 'package:aeyepetizer/entity/acategory.dart';
import 'package:aeyepetizer/model/base_list_view_model.dart';
import 'package:aeyepetizer/utils/json_utils.dart';
import 'package:flutter/foundation.dart';

class CategoryViewModel extends BaseListViewModel {
  Future getUrl() async {
    Map args = Map();
    args["action"] = UrlChannel.URL_CATEGORY;

    return await UrlChannel.get(args: args);
  }

  Future<List<ACategory>> loadData(int pn) async {
    return await getUrl().then((map) async {
      print("call:$map");
      List<ACategory> list;
      try {
        String url = map['url'];
        //print("loadData.url:$url");
        HttpResponse httpResponse = await HttpClient.instance.get(url);
        //print("result:${httpResponse.data}");
        //list = await compute(decodeListResult, httpResponse.data as String);
        final lb = await loadBalancer;
        list = await lb.run<List<ACategory>, String>(
            decodeListResult, httpResponse.data as String);
      } catch (e) {
        print(e);
        list = [];
      }
      return list;
    });
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
