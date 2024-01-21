import 'package:ghumfir_f/Models/post_tags_model.dart';

class PostModel {
  final int id;
  final String url;
  final String caption;
  final int numberOfLikes;
  final int numberOfDislikes;
  final int numberOfViews;
  final double? price;
  final int? duration;
  final List<PostTagsModel> postTags;

  PostModel(
    this.id,
    this.url,
    this.caption,
    this.numberOfLikes,
    this.numberOfDislikes,
    this.numberOfViews,
    this.price,
    this.duration,
    this.postTags,
  );

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        json["id"],
        json["url"],
        json["caption"],
        json["number_of_likes"],
        json["number_of_dislikes"],
        json["number_of_views"],
        json["price"] == null? null: json["price"]+ 0.0,
        json["duration"],
        (json["post_tags"] as List<dynamic>)
            .map((e) => PostTagsModel.fromJson(e))
            .toList());
  }
}
