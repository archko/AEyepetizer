import 'package:flutter_base/utils/string_utils.dart';

/// 新闻模型类
class DouyinNewsModel {
  late String title;
  late String shareUrl;
  late String author;
  late String itemCover;
  late int hotValue;
  late String hotWords;
  late int playCount;
  late int diggCount;
  late int commentCount;

  DouyinNewsModel.fromJson(Map<String, dynamic> json) {
    title = json["title"] ?? "";
    shareUrl = json["share_url"] ?? "";
    author = json["author"] ?? "";
    itemCover = json["item_cover"] ?? "";
    hotValue = json["hot_value"] ?? 0;
    hotWords = json["hot_words"] ?? "";
    playCount = json["play_count"] ?? 0;
    diggCount = json["digg_count"] ?? 0;
    commentCount = json["comment_count"] ?? 0;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = new Map<String, dynamic>();
    if (!StringUtils.isEmpty(title)) {
      map["title"] = title;
    }
    if (!StringUtils.isEmpty(shareUrl)) {
      map["share_url"] = shareUrl;
    }
    if (!StringUtils.isEmpty(author)) {
      map["author"] = author;
    }
    if (!StringUtils.isEmpty(itemCover)) {
      map["item_cover"] = itemCover;
    }
    map["hot_value"] = this.hotValue;
    map["play_count"] = this.playCount;
    map["digg_count"] = this.diggCount;
    map["comment_count"] = this.commentCount;
    if (!StringUtils.isEmpty(hotWords)) {
      map["hot_words"] = hotWords;
    }
    return map;
  }

  @override
  String toString() {
    return 'DouyinNewsModel{title: $title, shareUrl: $shareUrl, author: $author, itemCover: $itemCover, hotValue: $hotValue, hotWords: $hotWords, playCount: $playCount, diggCount: $diggCount, commentCount: $commentCount}';
  }
}
