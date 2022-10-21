import 'package:aeyepetizer/entity/douyin_news_model.dart';
import 'package:flutter_base/utils/object_utils.dart';

class DouyinNewsResult {
  int? error_code;
  String? reason;
  List<DouyinNewsModel>? result;

  DouyinNewsResult.fromJson(Map<String, dynamic> json) {
    error_code = json['error_code'];
    reason = json['reason'];
    result = json['result']
            ?.map<DouyinNewsModel>((item) => DouyinNewsModel.fromJson(item))
            ?.toList() ??
        [];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map["error_code"] = error_code;
    map["reason"] = reason;
    if (!ObjectUtils.isNull(result)) {
      map["result"] = result?.map((v) => v.toJson()).toList();
    }

    return map;
  }

  @override
  String toString() {
    return 'DouyinNewsResult{error_code: $error_code, reason: $reason, result: $result}';
  }
}