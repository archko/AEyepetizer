class Animate {
  Animate({
    this.additional,
    this.ename,
    this.jumplink,
    this.jumpquery,
    this.kg_pic_url,
    this.name,
    this.pic_6n_161,
    this.searchp,
    this.selpic,
    this.sort,
    this.statctl,
    this.statlst,
  });

  factory Animate.fromJson(Map<String, dynamic> json) {
    return Animate(
      additional: json['additional'],
      ename: json['ename'],
      jumplink: json['jumplink'],
      jumpquery: json['jumpquery'],
      kg_pic_url: json['kg_pic_url'],
      name: json['name'],
      pic_6n_161: json['pic_6n_161'],
      searchp: json['searchp'],
      selpic: json['selpic'],
      sort: json['sort'],
      statctl: json['statctl'],
      statlst: json['statlst'],
    );
  }

  String? additional;
  String? ename;
  String? jumplink;
  String? jumpquery;
  String? kg_pic_url;
  String? name;
  String? pic_6n_161;
  String? searchp;
  String? selpic;
  String? sort;
  String? statctl;
  String? statlst;
}
