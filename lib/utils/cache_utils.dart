import 'dart:async';

import 'package:aeyepetizer/entity/douyin_news_result.dart';
import 'package:aeyepetizer/entity/news_cache.dart';
import 'package:aeyepetizer/entity/wallpaper_bean.dart';
import 'package:flutter_base/utils/file_utils.dart';
import 'package:flutter_base/log/logger.dart';
import 'package:flutter_base/utils/json_utils.dart';
import 'package:flutter_base/utils/string_utils.dart';
import 'package:mmkv/mmkv.dart';

class CacheUtils {

  static const cache_wallpaper = "wallpaper";
  static const cache_news = "news";

  /// 从缓存文件读取文件内容
  static Future<String?> readStringFromCache(String cacheKey) async {
    String? cacheString = MMKV.defaultMMKV().decodeString(cacheKey);
    Logger.d("cacheString:$cacheString");
    if (!StringUtils.isEmpty(cacheString)) {
      NewsCache cache = NewsCache.fromJson(JsonUtils.decodeAsMap(cacheString!));
      String? dateString = cache.dateString;
      if (!StringUtils.isEmpty(dateString)) {
        DateTime _nowDate = DateTime.now();
        DateTime now = DateTime(_nowDate.year, _nowDate.month, _nowDate.day);
        DateTime cacheDate = DateTime.parse(dateString!);

        Logger.d("cacheDate:$cacheDate, now:$now");
        if (cacheDate.isBefore(now)) {
        } else {
          String result = await FileUtils.readFromFile(cache.filename!);
          Logger.d("result:$result");
          return result;
        }
      }
    }

    return null;
  }

  /// 写入缓存配置
  static void writeNewsCache(
      String cacheKey, String filename, String url) async {
    DateTime _nowDate = DateTime.now();
    String now = "${_nowDate.year}-${_nowDate.month}-${_nowDate.day}";
    NewsCache cache = new NewsCache(
      dateString: now,
      filename: filename,
      url: url,
    );
    Logger.d("now:$now, filename:$filename,cache:$cache");

    var json = JsonUtils.toJson(cache);
    await MMKV.defaultMMKV().encodeString(cacheKey, json);
  }

  static void writeNewsToCache(DouyinNewsResult newsResult, String url) async {
    String cacheKey = cache_news;
    String filename = "$cacheKey.json";
    writeNewsCache(cacheKey, filename, url);
    var newsJson = JsonUtils.toJson(newsResult);
    FileUtils.saveToFile(newsJson, filename);
  }

  static void writeNewsJsonToCache(String json, String url) async {
    String cacheKey = cache_news;
    String filename = "$cacheKey.json";
    writeNewsCache(cacheKey, filename, url);
    FileUtils.saveToFile(json, filename);
  }

  static void writeWallpaperToCache(WallpaperBean wallpaper, String url) async {
    String cacheKey = cache_wallpaper;
    String filename = "$cacheKey.json";
    writeNewsCache(cacheKey, filename, url);
    var newsJson = JsonUtils.toJson(wallpaper);
    FileUtils.saveToFile(newsJson, filename);
  }

  static void writeWallpaperJsonToCache(String json, String url) async {
    String cacheKey = cache_wallpaper;
    String filename = "$cacheKey.json";
    writeNewsCache(cacheKey, filename, url);
    FileUtils.saveToFile(json, filename);
  }
}
