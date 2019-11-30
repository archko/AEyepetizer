import 'package:aeyepetizer/common/bridge/url_channel.dart';
import 'package:aeyepetizer/common/http/http_client.dart';
import 'package:aeyepetizer/common/http/http_response.dart';
import 'package:aeyepetizer/entity/acategory.dart';
import 'package:aeyepetizer/model/base_list_view_model.dart';
import 'package:aeyepetizer/utils/json_utils.dart';
import 'package:flutter/foundation.dart';

class CategoryViewModel extends BaseListViewModel {
  getUrl(callback) async {
    Map args = Map();
    args["action"] = UrlChannel.URL_CATEGORY;

    return await UrlChannel.get(args: args, callback: callback);
  }

  Future<List<ACategory>> loadData(int pn) async {
    List<ACategory> list;

    getUrl((dynamic result) async {
      print("call:$result");
      try {
        String url = result['url'];
        //print("loadData.url:$url");

        HttpResponse httpResponse = await HttpClient.instance.get(url);
        print("result:${httpResponse.data}");
        list = await compute(decodeListResult, httpResponse.data as String);
      } catch (e) {
        print(e);
        list = [];
      }
    });
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
