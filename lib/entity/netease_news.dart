class NeteaseNews {
  NeteaseNews({
    this.liveInfo,
    this.docid,
    this.source,
    this.title,
    this.priority,
    this.hasImg,
    this.url,
    this.commentCount,
    this.imgsrc3gtype,
    this.stitle,
    this.digest,
    this.imgsrc,
    this.ptime,
  });

  NeteaseNews.fromJson(dynamic json) {
    liveInfo = json['liveInfo'];
    docid = json['docid'];
    source = json['source'];
    title = json['title'];
    priority = json['priority'];
    hasImg = json['hasImg'];
    url = json['url'];
    commentCount = json['commentCount'];
    imgsrc3gtype = json['imgsrc3gtype'];
    stitle = json['stitle'];
    digest = json['digest'];
    imgsrc = json['imgsrc'];
    ptime = json['ptime'];
  }

  String? liveInfo;
  String? docid;
  String? source;
  String? title;
  int? priority;
  int? hasImg;
  String? url;
  int? commentCount;
  String? imgsrc3gtype;
  String? stitle;
  String? digest;
  String? imgsrc;
  String? ptime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['liveInfo'] = liveInfo;
    map['docid'] = docid;
    map['source'] = source;
    map['title'] = title;
    map['priority'] = priority;
    map['hasImg'] = hasImg;
    map['url'] = url;
    map['commentCount'] = commentCount;
    map['imgsrc3gtype'] = imgsrc3gtype;
    map['stitle'] = stitle;
    map['digest'] = digest;
    map['imgsrc'] = imgsrc;
    map['ptime'] = ptime;
    return map;
  }
}
