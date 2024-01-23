import 'package:flutter/material.dart';
import 'package:ghumfir_f/MyHomePage/Recommenadation/RecommendationCard.dart';
import 'package:ghumfir_f/services/RecommendationService.dart';
import '../../Models/post_model.dart';

class Recommenadation extends StatefulWidget {
  const Recommenadation({Key? key}) : super(key: key);

  @override
  State<Recommenadation> createState() => _RecommenadationState();
}

class _RecommenadationState extends State<Recommenadation> {
  int page = 1;
  List<PostModel>? posts;
  late Future<List<PostModel>?> future =
      RecommendationService().fetchFeed(page, context);
  final ScrollController controller = ScrollController();
  bool disable = false;
  bool limitReached = false;

  @override
  void initState() {
    super.initState();
    controller.addListener(() async {
      if (controller.position.pixels >=
              controller.position.maxScrollExtent - 100 &&
          !disable &&
          !limitReached) {
        disable = true;
        page++;
        List<PostModel>? posts =
            await RecommendationService().fetchFeed(page, context);
        if (posts != null) {
          if (posts.length < 3) {
            limitReached = true;
          }
          setState(() {
            this.posts?.addAll(posts);
          });
        }
        disable = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              }
              posts ??= snapshot.data;
              return ListView(
                physics: const BouncingScrollPhysics(),
                controller: controller,
                padding:
                    const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                children: posts!
                    .asMap()
                    .entries
                    .map(
                      (e) => Column(
                        children: [
                          RecommendationCard(e.value),
                          SizedBox(
                            height: 42,
                          ),
                        ],
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}
