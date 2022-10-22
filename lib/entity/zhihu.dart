class Zhihu {
  Zhihu({
    required this.newsId,
    this.url = "",
    this.thumbnail = "",
    this.title = "",
  });

  Zhihu.fromJson(dynamic json) {
    newsId = json['news_id'];
    url = json['url'];
    thumbnail = json['thumbnail'];
    title = json['title'];
  }

  int newsId = 0;
  String url = "";
  String thumbnail = "";
  String title = "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['news_id'] = newsId;
    map['url'] = url;
    map['thumbnail'] = thumbnail;
    map['title'] = title;
    return map;
  }
}
