import 'package:aeyepetizer/common/bridge/url_channel.dart';
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

  Future getUrl(ACategory category) async {
    Map args = Map();
    args["action"] = UrlChannel.URL_CATEGORY_BY_ID;
    args['categoryId'] = category.id;

    return await UrlChannel.get(args: args);
  }

  Future<Trending> loadData(int pn, [ACategory category]) async {
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
    return await getUrl(category).then((map) async {
      print("getUrl:$map");
      Trending trending;
      try {
        String url = map['url'];
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
    });
  }

  Future<Trending> loadMore(int pn) async {
    return loadData(pn);
  }

  static Trending decodeListResult(String result) {
    var results = JsonUtils.decodeAsMap(result);
    Trending beans = Trending.fromJson(results);

    return beans;
  }
}
