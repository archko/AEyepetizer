import 'dart:async';

import 'package:aeyepetizer/common/http/web_config.dart';
import 'package:aeyepetizer/entity/NewsResult.dart';
import 'package:aeyepetizer/entity/acategory.dart';
import 'package:aeyepetizer/entity/trending.dart';
import 'package:aeyepetizer/entity/wallpaper_bean.dart';
import 'package:aeyepetizer/page/hot/hot_video_list_page.dart';
import 'package:flutter_base/http/http_client.dart';
import 'package:flutter_base/http/http_response.dart';
import 'package:flutter_base/utils/isolate_utils.dart';
import 'package:flutter_base/utils/json_utils.dart';

class VideoRepository {
  static final VideoRepository _instance = VideoRepository();

  static VideoRepository get singleton => _instance;

  Future<List<ACategory>> loadData([int? pn]) async {
    List<ACategory> list;
    try {
      Map<String, dynamic> args = Map();
      args['udid'] = 'd2807c895f0348a180148c9dfa6f2feeac0781b5';
      args['deviceModel'] = 'vivo x21';

      HttpResponse httpResponse =
          await HttpClient.instance.get(WebConfig.categoriesUrl, params: args);
      print("result:${httpResponse.data}");
      list = await run<List<ACategory>, String>(
          decodeListResult, httpResponse.data as String);
    } catch (e) {
      print(e);
      list = [];
    }
    return list;
  }

  static List<ACategory> decodeListResult(String result) {
    var results = JsonUtils.decodeAsList(result);
    List<ACategory> beans = List.empty(growable: true);
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

  Future<Trending?> loadTrending(int pn, Trending? last,
      {String? type, ACategory? category}) async {
    if (pn < 0 && last != null) {
      Trending? trending;
      try {
        String? url = last.nextPageUrl;
        HttpResponse httpResponse = await HttpClient.instance.get(url);
        trending = await run<Trending, String>(
            decodeTrendingResult, httpResponse.data as String);
        //print("result:${list}");
      } catch (e) {
        print(e);
        trending = null;
      }
      return trending;
    }
    Trending? trending;
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
      trending = await run<Trending, String>(
          decodeTrendingResult, httpResponse.data as String);
      //print("result:${list}");
    } catch (e) {
      print(e);
      trending = null;
    }
    return trending;
  }

  Future<Trending?> loadDailySelection(int pn, Trending? last) async {
    Map<String, dynamic> args = Map();
    args['udid'] = 'd2807c895f0348a180148c9dfa6f2feeac0781b5';
    args['deviceModel'] = 'vivo x21';
    args['page'] = pn;
    if (pn < 0 && last != null) {
      Trending? trending;
      try {
        String? url = last.nextPageUrl;
        HttpResponse httpResponse =
            await HttpClient.instance.get(url, params: args);
        trending = await run<Trending, String>(
            decodeTrendingResult, httpResponse.data as String);
        //print("result:${list}");
      } catch (e) {
        print(e);
        trending = null;
      }
      return trending;
    }
    Trending? trending;
    try {
      HttpResponse httpResponse = await HttpClient.instance
          .get(WebConfig.dailySelectionUrl, params: args);
      trending = await run<Trending, String>(
          decodeTrendingResult, httpResponse.data as String);
      //print("result:${list}");
    } catch (e) {
      print(e);
      trending = null;
    }
    return trending;
  }

  static NewsResult decodeNewsModel(String result) {
    var results = JsonUtils.decodeAsMap(result);
    NewsResult beans = NewsResult.fromJson(results);

    return beans;
  }

  Future<NewsResult?> getNews() async {
    NewsResult? newsResult;
    try {
      Map<String, dynamic> args = Map();
      HttpResponse httpResponse = await HttpClient.instance.get(
          "http://apis.juhe.cn/fapig/douyin/billboard?type=hot_video&size=50&key=9eb8ac7020d9bea6048db1f4c6b6d028",
          params: args);
      newsResult = await run<NewsResult, String>(
          decodeNewsModel, httpResponse.data as String);
      //print("result:${list}");
    } catch (e) {
      print(e);
      newsResult = null;
    }
    return newsResult;
  }

  static WallpaperBean decodeWallpaper(String result) {
    var results = JsonUtils.decodeAsMap(result);
    WallpaperBean bean = WallpaperBean.fromJson(results);

    return bean;
  }

  Future<WallpaperBean?> getWallpaperBean() async {
    WallpaperBean? wallpaperBean;
    try {
      Map<String, dynamic> args = Map();
      HttpResponse httpResponse = await HttpClient.instance
          .get("https://v.api.aa1.cn/api/api-meiribizhi/api.php", params: args);
      wallpaperBean = await run<WallpaperBean, String>(
          decodeWallpaper, httpResponse.data as String);
      //print("result:${list}");
    } catch (e) {
      print(e);
      wallpaperBean = null;
    }
    return wallpaperBean;
  }
}
