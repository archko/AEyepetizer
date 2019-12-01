import 'package:aeyepetizer/entity/video_data.dart';

class VideoItem {
  String type;
  int id;
  int adIndex;
  VideoData data;

  VideoItem.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    adIndex = json['adIndex'];
    type = json['type'];
    var results = json['data'];
    if (results != null) {
      data = VideoData.fromJson(results);
    }
  }

  @override
  String toString() {
    return 'VideoItem{ type: $type,id:$id, data:$data}';
  }
}
