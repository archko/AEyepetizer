import 'dart:async';
import 'dart:io';

import 'package:aeyepetizer/common/http/web_config.dart';
import 'package:aeyepetizer/entity/acategory.dart';
import 'package:aeyepetizer/entity/trending.dart';
import 'package:aeyepetizer/page/hot/hot_video_list_page.dart';
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
      list = await loadWithBalancer<List<ACategory>, String>(
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

  static Trending decodeTrendingResult(String result) {
    var results = JsonUtils.decodeAsMap(result);
    Trending beans = Trending.fromJson(results);

    return beans;
  }

  Future<Trending> loadTrending(int pn, Trending last,
      {String type, ACategory category}) async {
    if (pn < 0 && last != null) {
      Trending trending;
      try {
        String url = last.nextPageUrl;
        HttpResponse httpResponse = await HttpClient.instance.get(url);
        trending = await loadWithBalancer<Trending, String>(
            decodeTrendingResult, httpResponse.data as String);
        //print("result:${list}");
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
      if (category != null) {
        args['id'] = category.id;
      }
      if (type != null) {
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
      }
      HttpResponse httpResponse =
          await HttpClient.instance.get(WebConfig.hotUrl, params: args);
      trending = await loadWithBalancer<Trending, String>(
          decodeTrendingResult, httpResponse.data as String);
      //print("result:${list}");
    } catch (e) {
      print(e);
      trending = null;
    }
    return trending;
  }
}
