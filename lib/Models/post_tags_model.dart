class PostTagsModel {
  final TagModel tag;
  final String value;

  PostTagsModel(this.tag, this.value);

  factory PostTagsModel.fromJson(Map<String, dynamic> json) {
    return PostTagsModel(TagModel.fromJson(json["tag"]), json["value"]);
  }
}

class TagModel {
  final String key;

  TagModel(this.key);

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(json["key"]);
  }
}
