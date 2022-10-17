/// 新闻模型类
class NewsModel {
  late String title;
  late String shareUrl;
  late String author;
  late String itemCover;
  late int hotValue;
  late String hotWords;
  late int playCount;
  late int diggCount;
  late int commentCount;

  NewsModel.fromJson(Map<String, dynamic> json) {
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
}
