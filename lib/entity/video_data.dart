import 'package:aeyepetizer/entity/author.dart';
import 'package:aeyepetizer/entity/consumption.dart';
import 'package:aeyepetizer/entity/cover.dart';
import 'package:aeyepetizer/entity/tag.dart';
import 'package:aeyepetizer/entity/weburl.dart';

class VideoData {
  //textCard,VideoBeanForClient are for category by id.
  //video for video detail
  String dataType;
  int id;
  String title;
  String description;
  String library;
  String resourceType;
  String category;
  String playUrl;
  int duration;
  int releaseTime;
  int date;
  String descriptionEditor;
  Consumption consumption;
  Author author;
  Cover cover;
  List<Tag> tags;
  WebUrl webUrl;
  //textcard
  String text;

  VideoData.fromJson(Map<String, dynamic> json) {
    dataType = json['dataType'];
    id = json['id'];
    title = json['title'];
    description = json['description'];
    library = json['library'];
    resourceType = json['resourceType'];
    category = json['category'];
    playUrl = json['playUrl'];
    duration = json['duration'];
    releaseTime = json['releaseTime'];
    date = json['date'];
    descriptionEditor = json['descriptionEditor'];

    text = json['text'];

    var results = json['consumption'];
    if (results != null) {
      consumption = Consumption.fromJson(results);
    }
    results = json['author'];
    if (results != null) {
      author = Author.fromJson(results);
    }
    results = json['cover'];
    if (results != null) {
      cover = Cover.fromJson(results);
    }
    results = json['webUrl'];
    if (results != null) {
      webUrl = WebUrl.fromJson(results);
    }
    tags = json['tags']?.map<Tag>((item) => Tag.fromJson(item))?.toList() ?? [];
  }

  @override
  String toString() {
    return 'VideoData{dataType:$dataType,id:$id, title: $title,playUrl:$playUrl}'
        ',consumption:$consumption,author:$author, cover:$cover,webUrl:$webUrl';
  }
}
