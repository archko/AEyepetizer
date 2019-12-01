class Tag {
  int id;
  String name;
  String
      actionUrl; //"eyepetizer://tag/1032/?title=%E7%BB%99%E4%BD%A0%E8%AE%B2%E4%B8%AA%E5%A5%BD%E6%95%85%E4%BA%8B",
  String desc;
  String
      bgPicture; //": "http://img.kaiyanapp.com/d471080a9de44e8fbaa4850887273332.jpeg?imageMogr2/quality/60/format/jpg",
  String
      headerImage; //": "http://img.kaiyanapp.com/33a2b832b7583dd9781f9fd40ad7617e.jpeg?imageMogr2/quality/60/format/jpg",

  Tag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    actionUrl = json['actionUrl'];
    desc = json['desc'];
    bgPicture = json['bgPicture'];
    headerImage = json['headerImage'];
  }
}
