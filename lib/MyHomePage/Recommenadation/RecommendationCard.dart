import 'package:flutter/material.dart';
import 'package:ghumfir_f/Models/post_action_model.dart';
import 'package:ghumfir_f/Models/post_model.dart';
import 'package:ghumfir_f/services/LikeDislikeService.dart';
import 'package:collection/collection.dart';
import '../../api.dart';

class RecommendationCard extends StatefulWidget {
  final PostModel item;
  final Function(PostModel post) onUpdate;

  const RecommendationCard(this.item, this.onUpdate, {super.key});

  @override
  State<RecommendationCard> createState() => _RecommendationCardState();
}

class _RecommendationCardState extends State<RecommendationCard> {
  bool disabled = false;

  @override
  Widget build(BuildContext context) {
    print(widget.item.url);
    PostAction? myAction = widget.item.postActions
        .firstWhereOrNull((e) => e.user.id == Api.user?.id)
        ?.action;
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 34, 33, 33),
          border: Border.all(color: Colors.white, strokeAlign: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Builder(builder: (ctx) {
              return Hero(
                tag: "card-to-description${widget.item.id}",
                child: Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                      maxHeight: constraints.maxWidth * 0.4,
                      minHeight: constraints.maxWidth * 0.2),
                  child: widget.item.url == null
                      ? Center(child: CircularProgressIndicator())
                      : Image.network(
                          "${Api.baseUrl.substring(0, Api.baseUrl.length - 1)}${widget.item.url}",
                          fit: BoxFit.cover,
                          errorBuilder: (context, obj, stackTrace) =>
                              Image.network(
                            "${Api.baseUrl}${widget.item.url}",
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              );
            }),
            const SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.item.name ?? "Unknown",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.3),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            if (widget.item.price != null)
                              Text(
                                "NPR ${widget.item.price}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.5),
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.3,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Text(
                        "${widget.item.numberOfLikes}",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      InkWell(
                        onTap: () async {
                          if (disabled) return;
                          disabled = true;
                          PostModel? post = await LikeDislikeService()
                              .likePost(widget.item.id, context);
                          disabled = false;
                          if (post != null) widget.onUpdate(post);
                        },
                        child: Icon(
                          myAction == PostAction.LK
                              ? Icons.thumb_up_sharp
                              : Icons.thumb_up_outlined,
                          color: Colors.green,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      InkWell(
                        onTap: () async {
                          if (disabled) return;
                          disabled = true;
                          PostModel? post = await LikeDislikeService()
                              .dislikePost(widget.item.id, context);
                          disabled = false;
                          if (post != null) widget.onUpdate(post);
                        },
                        child: Icon(
                          myAction == PostAction.DL
                              ? Icons.thumb_down_sharp
                              : Icons.thumb_down_outlined,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        "${widget.item.numberOfDislikes}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Positioned(
                    top: -70,
                    child: Container(
                      width: constraints.maxWidth,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12.0 + 12 + 12),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 34, 33, 33),
                            border: Border.all(
                                color: Colors.white.withOpacity(0.1),
                                strokeAlign: 1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.access_time_filled_sharp,
                                  color: Color(0xff2c5f2d),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  [
                                    "${(widget.item.duration ?? 1).toString()} Days",
                                    "${widget.item.numberOfViews} views"
                                  ].join(" • "),
                                  style: TextStyle(color: Colors.white),
                                ),
                                Expanded(child: Container()),
                                const Icon(
                                  Icons.location_pin,
                                  color: Color(0xff2c5f2d),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(getCapitalized(widget.item.location),
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  String getCapitalized(String? location) {
    if (location?.isEmpty ?? true) return "Nepal";
    return location!
        .split(" ")
        .map((e) => e[0].toUpperCase() + e.substring(1))
        .join(" ");
  }
}
