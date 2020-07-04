import 'package:aeyepetizer/common/http/web_config.dart';
import 'package:aeyepetizer/entity/acategory.dart';
import 'package:aeyepetizer/entity/trending.dart';
import 'package:aeyepetizer/entity/video_item.dart';
import 'package:flutter_base/http/http_client.dart';
import 'package:flutter_base/http/http_response.dart';
import 'package:flutter_base/model/base_list_view_model.dart';
import 'package:flutter_base/utils/isolate_utils.dart';
import 'package:flutter_base/utils/json_utils.dart';

class VideoByCategoryViewModel extends BaseListViewModel<VideoItem> {
  Trending last;

  Future<Trending> loadData({int pn, ACategory category}) async {
    if (pn < 0 && last != null) {
      Trending trending;
      try {
        String url = last.nextPageUrl;
        HttpResponse httpResponse = await HttpClient.instance.get(url);
        //trending = await compute(decodeListResult, httpResponse.data as String);

        final lb = await loadBalancer;
        trending = await lb.run<Trending, String>(
            decodeListResult, httpResponse.data as String);
        //print("result:${list}");
        last = trending;
      } catch (e) {
        print(e);
        trending = null;
      }
      return trending;
    }
    Trending trending;
    try {
      Map<String, dynamic> args = Map();
      args['udid'] = 'd2807c895f0348a180148c9dfa6f2feeac0781b5';
      args['deviceModel'] = 'vivo x21';
      args['id'] = category.id;
      HttpResponse httpResponse = await HttpClient.instance
          .get(WebConfig.categoryDetailUrl, params: args);
      //trending = await compute(decodeListResult, httpResponse.data as String);
      final lb = await loadBalancer;
      trending = await lb.run<Trending, String>(
          decodeListResult, httpResponse.data as String);
      //print("result:${list}");
      last = trending;
    } catch (e) {
      print(e);
      trending = null;
    }
    return trending;
  }

  Future<Trending> loadMore({int pn}) async {
    return loadData(pn: pn);
  }

  static Trending decodeListResult(String result) {
    var results = JsonUtils.decodeAsMap(result);
    Trending beans = Trending.fromJson(results);

    return beans;
  }
}
