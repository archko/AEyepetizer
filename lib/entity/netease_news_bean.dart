import 'netease_news.dart';

class NeteaseNewsBean {
  NeteaseNewsBean({
    this.news,
  });

  NeteaseNewsBean.fromJson(dynamic json) {
    if (json['BA8EE5GMwangning'] != null) {
      news = [];
      json['BA8EE5GMwangning'].forEach((v) {
        news?.add(NeteaseNews.fromJson(v));
      });
    }
  }

  List<NeteaseNews>? news;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (news != null) {
      map['BA8EE5GMwangning'] = news?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
