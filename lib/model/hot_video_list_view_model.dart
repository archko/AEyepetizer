import 'package:aeyepetizer/common/bridge/url_channel.dart';
import 'package:aeyepetizer/entity/trending.dart';
import 'package:aeyepetizer/model/video_by_category_view_model.dart';
import 'package:aeyepetizer/page/hot/hot_video_list_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_base/http/http_client.dart';
import 'package:flutter_base/http/http_response.dart';
import 'package:flutter_base/model/base_list_view_model.dart';
import 'package:flutter_base/utils/isolate_utils.dart';

class HotVideoListViewModel extends BaseListViewModel {
  Trending last;

  Future getUrl(String type) async {
    Map args = Map();
    switch (type) {
      case HotVideoListPage.TYPE_HOT_WEEKLY:
        args["action"] = UrlChannel.URL_HOT_WEEKLY;
        break;
      case HotVideoListPage.TYPE_HOT_MONTHLY:
        args["action"] = UrlChannel.URL_HOT_MONTHLY;
        break;
      case HotVideoListPage.TYPE_TOTAL_RANKING:
        args["action"] = UrlChannel.URL_TOTAL_RANKING;
        break;
    }

    return await UrlChannel.get(args: args);
  }

  Future<Trending> loadData(int pn, [String type]) async {
    if (pn < 0 && last != null) {
      Trending trending;
      try {
        String url = last.nextPageUrl;
        HttpResponse httpResponse = await HttpClient.instance.get(url);
        //trending = await compute(VideoByCategoryViewModel.decodeListResult,
        //    httpResponse.data as String);
        final lb = await loadBalancer;
        trending = await lb.run<Trending, String>(
            VideoByCategoryViewModel.decodeListResult,
            httpResponse.data as String);
        //print("result:${list}");
        last = trending;
      } catch (e) {
        print(e);
        trending = null;
      }
      return trending;
    }
    return await getUrl(type).then((map) async {
      print("getUrl:$map");
      Trending trending;
      try {
        String url = map['url'];
        HttpResponse httpResponse = await HttpClient.instance.get(url);
        //trending = await compute(VideoByCategoryViewModel.decodeListResult,
        //    httpResponse.data as String);
        final lb = await loadBalancer;
        trending = await lb.run<Trending, String>(
            VideoByCategoryViewModel.decodeListResult,
            httpResponse.data as String);
        //print("result:${list}");
        last = trending;
      } catch (e) {
        print(e);
        trending = null;
      }
      return trending;
    });
  }

  Future<Trending> loadMore(int pn, [String type]) async {
    return loadData(pn, type);
  }
}
