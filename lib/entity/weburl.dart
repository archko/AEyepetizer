class WebUrl {
  String? raw; //": "http://www.eyepetizer.net/detail.html?vid=179446",
  String?
      forWeibo; //": "http://www.eyepetizer.net/detail.html?vid=179446&resourceType=video&utm_campaign=routine&utm_medium=share&utm_source=weibo&uid=0"
  WebUrl.fromJson(Map<String, dynamic> json) {
    raw = json['raw'];
    forWeibo = json['forWeibo'];
  }

  @override
  String toString() {
    return 'WebUrl{ raw: $raw,$forWeibo}';
  }
}
