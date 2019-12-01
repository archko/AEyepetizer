class Author {
  int id;
  String icon;
  String name;
  String description;
  String link;
  int latestReleaseTime;
  int videoNum;
  int approvedNotReadyVideoCount;
  bool ifPgc;
  int recSort;
  bool expert;

  Author.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    name = json['name'];
    description = json['description'];
    link = json['link'];
    latestReleaseTime = json['latestReleaseTime'];
    videoNum = json['videoNum'];
    approvedNotReadyVideoCount = json['approvedNotReadyVideoCount'];
  }

  @override
  String toString() {
    return 'Author{ name: $name,icon:$icon}';
  }
}
