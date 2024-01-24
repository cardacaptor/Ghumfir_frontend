import 'package:flutter/material.dart';
import 'package:ghumfir_f/Models/post_action_model.dart';
import 'package:ghumfir_f/Models/post_model.dart';
import 'package:ghumfir_f/MyHomePage/Recommenadation/DescriptionDetail.dart';
import 'package:ghumfir_f/services/LikeDislikeService.dart';
import 'package:collection/collection.dart';
import '../../api.dart';

class RecommendationCard extends StatefulWidget {
  final PostModel item;
  final Function(PostModel post) onUpdate;

  RecommendationCard(this.item, this.onUpdate);

  @override
  State<RecommendationCard> createState() => _RecommendationCardState();
}

class _RecommendationCardState extends State<RecommendationCard> {
  bool disabled = false;

  @override
  Widget build(BuildContext context) {
    PostAction? myAction = widget.item.postActions
        .firstWhereOrNull((e) => e.user.id == Api.user?.id)
        ?.action;
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 2),
              ),
            ],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Builder(builder: (ctx) {
                return Container(
                  height: 500,
                  child: Hero(
                    tag: "card-to-description${widget.item.id}",
                    child: Image.network(
                      "${Api.baseUrl}${widget.item.url}",
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                      height: MediaQuery.of(context).size.height,
                    ),
                  ),
                );
              }),
              const SizedBox(
                height: 22,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.caption,
                          style: TextStyle(
                              fontSize: 16,
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
                              fontSize: 18,
                              color: Color(0xff0394B6),
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.3,
                            ),
                          ),
                      ],
                    ),
                    Expanded(child: Container()),
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
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: widget.item.price != null ? 80 : 54,
          left: 0,
          right: 0,
          child: Container(
            margin: EdgeInsets.all(12),
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.access_time_filled_sharp,
                    color: Color(0xff2c5f2d),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text("5 days"),
                  Expanded(child: Container()),
                  const Icon(
                    Icons.location_pin,
                    color: Color(0xff2c5f2d),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text("Kathmandu"),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
