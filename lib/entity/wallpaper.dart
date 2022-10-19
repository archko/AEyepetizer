import 'package:flutter_base/utils/string_utils.dart';

class Wallpaper {
  Wallpaper({
    this.id,
    this.classId,
    this.tag,
    this.url,
    this.utag,
    this.resolution,
    this.createTime,
    this.img_1600_900,
    this.img_1440_900,
    this.img_1366_768,
    this.img_1280_800,
    this.img_1280_1024,
    this.img_1024_768,
  });

  Wallpaper.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    classId = json['class_id'];
    tag = json['tag'];
    url = json['url'];
    utag = json['utag'];
    resolution = json['resolution'];
    createTime = json['create_time'];
    img_1600_900 = json['img_1600_900'];
    img_1440_900 = json['img_1440_900'];
    img_1366_768 = json['img_1366_768'];
    img_1280_800 = json['img_1280_800'];
    img_1280_1024 = json['img_1280_1024'];
    img_1024_768 = json['img_1024_768'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = new Map<String, dynamic>();
    if (!StringUtils.isEmpty(id)) {
      map["id"] = id;
    }
    if (!StringUtils.isEmpty(classId)) {
      map["class_id"] = classId;
    }
    if (!StringUtils.isEmpty(tag)) {
      map["tag"] = tag;
    }
    if (!StringUtils.isEmpty(url)) {
      map["url"] = url;
    }
    map["utag"] = this.utag;
    map["resolution"] = this.resolution;
    map["create_time"] = this.createTime;
    map["img_1600_900"] = this.img_1600_900;
    map["img_1440_900"] = img_1440_900;
    map["img_1366_768"] = img_1366_768;
    map["img_1366_768"] = img_1366_768;
    map["img_1280_800"] = img_1280_800;
    map["img_1280_800"] = img_1280_800;
    map["img_1280_1024"] = img_1280_1024;
    map["img_1024_768"] = img_1024_768;
    return map;
  }

  String? id;
  String? classId;
  String? tag;
  String? url;
  String? utag;
  String? createTime;
  String? resolution;
  String? img_1600_900;
  String? img_1440_900;
  String? img_1366_768;
  String? img_1280_800;
  String? img_1280_1024;
  String? img_1024_768;

  @override
  String toString() {
    return 'Wallpaper{classId: $classId, tag: $tag, url: $url, utag: $utag, createTime: $createTime, resolution: $resolution, img_1600_900: $img_1600_900, img_1024_768: $img_1024_768}';
  }
}
