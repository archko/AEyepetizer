import 'package:aeyepetizer/entity/video_item.dart';

class Trending {
  int count;
  int total;
  bool adExist;
  String nextPageUrl;
  List<VideoItem> itemList;

  Trending.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    total = json['total'];
    adExist = json['adExist'];
    nextPageUrl = json['nextPageUrl'];
    itemList = json['itemList']
            ?.map<VideoItem>((item) => VideoItem.fromJson(item))
            ?.toList() ??
        [];
  }

  @override
  String toString() {
    return 'Trending{ count: $count,total:$total, nextPageUrl:$nextPageUrl, itemList:$itemList}';
  }
}
