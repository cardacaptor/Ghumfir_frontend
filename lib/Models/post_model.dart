import 'package:ghumfir_f/Models/post_action_model.dart';
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
  final String? location;
  final List<PostTagsModel> postTags;
  final List<PostActionModel> postActions;

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
    this.postActions,
    this.location,
  );

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
        json["id"],
        json["url"],
        json["caption"],
        json["number_of_likes"],
        json["number_of_dislikes"],
        json["number_of_views"],
        json["price"] == null ? null : json["price"] + 0.0,
        json["duration"],
        (json["post_tags"] as List<dynamic>)
            .map((e) => PostTagsModel.fromJson(e))
            .toList(),
        (json["actions"] as List<dynamic>)
            .map((e) => PostActionModel.fromJson(e))
            .toList(),
        json["category"]?["caption"]);
  }

  PostModel copyWith({
    int? id,
    String? url,
    String? caption,
    int? numberOfLikes,
    int? numberOfDislikes,
    int? numberOfViews,
    double? price,
    int? duration,
    List<PostTagsModel>? postTags,
    List<PostActionModel>? postActions,
    String? location,
  }) =>
      PostModel(
        id ?? this.id,
        url ?? this.url,
        caption ?? this.caption,
        numberOfLikes ?? this.numberOfLikes,
        numberOfDislikes ?? this.numberOfDislikes,
        numberOfViews ?? this.numberOfViews,
        price ?? this.price,
        duration ?? this.duration,
        postTags ?? this.postTags,
        postActions ?? this.postActions,
        location ?? this.location,
      );
}
