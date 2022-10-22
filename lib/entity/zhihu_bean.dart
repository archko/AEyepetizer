import 'zhihu.dart';

class ZhihuBean {
  ZhihuBean({
    this.recent,
  });

  ZhihuBean.fromJson(dynamic json) {
    if (json['recent'] != null) {
      recent = [];
      json['recent'].forEach((v) {
        recent?.add(Zhihu.fromJson(v));
      });
    }
  }

  List<Zhihu>? recent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (recent != null) {
      map['recent'] = recent?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
