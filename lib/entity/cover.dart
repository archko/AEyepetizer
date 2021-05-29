class Cover {
  String?
      feed; //": "http://img.kaiyanapp.com/a726e9ed0d65aa8afefb3df3aebb67e3.png?imageMogr2/quality/60/format/jpg",
  String?
      detail; //": "http://img.kaiyanapp.com/a726e9ed0d65aa8afefb3df3aebb67e3.png?imageMogr2/quality/60/format/jpg",
  String?
      blurred; //": "http://img.kaiyanapp.com/2c7ca7fb77a3ad3057d4a0fbe2c2cbf2.jpeg?imageMogr2/quality/60/format/jpg",
  String? sharing; //": null,
  String? homepage; //": null
  Cover.fromJson(Map<String, dynamic> json) {
    feed = json['feed'];
    detail = json['detail'];
    blurred = json['blurred'];
    sharing = json['sharing'];
    homepage = json['homepage'];
  }

  @override
  String toString() {
    return 'Cover{ feed: $feed,detail:$detail}';
  }
}
