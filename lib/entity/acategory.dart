class ACategory {
  ACategory({
    this.id,
    this.tagId,
    this.defaultAuthorId,
    this.name,
    this.description,
    this.bgPicture,
    this.headerImage,
  });

  ACategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tagId = json['tagId'];
    defaultAuthorId = json['defaultAuthorId'];
    name = json['name'];
    description = json['description'];
    bgPicture = json['bgPicture'];
    headerImage = json['headerImage'];
  }

  int? id;
  int? tagId;
  int? defaultAuthorId;
  String? name;
  String? description;
  String? bgPicture;
  String? headerImage;
}
