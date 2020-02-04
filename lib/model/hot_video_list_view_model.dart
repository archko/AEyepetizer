import 'package:aeyepetizer/common/http/web_config.dart';
import 'package:aeyepetizer/entity/trending.dart';
import 'package:aeyepetizer/model/video_by_category_view_model.dart';
import 'package:aeyepetizer/page/hot/hot_video_list_page.dart';
import 'package:flutter_base/http/http_client.dart';
import 'package:flutter_base/http/http_response.dart';
import 'package:flutter_base/model/base_list_view_model.dart';
import 'package:flutter_base/utils/isolate_utils.dart';

class HotVideoListViewModel extends BaseListViewModel {
  Trending last;

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
    Trending trending;
    try {
      Map<String, dynamic> args = Map();
      args['udid'] = 'd2807c895f0348a180148c9dfa6f2feeac0781b5';
      args['deviceModel'] = 'vivo x21';
      switch (type) {
        case HotVideoListPage.TYPE_HOT_WEEKLY:
          args['strategy'] = 'weekly';
          break;
        case HotVideoListPage.TYPE_HOT_MONTHLY:
          args['strategy'] = 'monthly';
          break;
        case HotVideoListPage.TYPE_TOTAL_RANKING:
          args['strategy'] = 'historical';
          break;
      }
      HttpResponse httpResponse =
          await HttpClient.instance.get(WebConfig.hotUrl, params: args);
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

  Future<Trending> loadMore(int pn, [String type]) async {
    return loadData(pn, type);
  }
}
