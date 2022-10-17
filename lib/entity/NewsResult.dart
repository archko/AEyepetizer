import 'package:aeyepetizer/entity/NewsModel.dart';

class NewsResult {
  int? error_code;
  String? reason;
  List<NewsModel>? result;

  NewsResult.fromJson(Map<String, dynamic> json) {
    error_code = json['error_code'];
    reason = json['reason'];
    result = json['result']
            ?.map<NewsModel>((item) => NewsModel.fromJson(item))
            ?.toList() ??
        [];
  }

  @override
  String toString() {
    return 'Trending{error_code: $error_code, reason: $reason, result: $result}';
  }
}
