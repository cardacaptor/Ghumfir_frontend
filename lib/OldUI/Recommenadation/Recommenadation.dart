import 'package:flutter/material.dart';
import 'package:ghumfir_f/MyHomePage/Recommenadation/RecommendationCard.dart';
import 'package:ghumfir_f/services/RecommendationService.dart';
import 'package:google_fonts/google_fonts.dart';

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
          height: 120,
        ),
        Row(
          children: [
            Expanded(child: Container()),
            Container(
              width: 40,
              height: 2,
              color: Colors.black,
            ),
            Text(
              "  RECOMMENDED FOR YOU  ",
              style: GoogleFonts.rufina(
                textStyle: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              width: 40,
              height: 2,
              color: Colors.black,
            ),
            Expanded(child: Container()),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 500,
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
                  scrollDirection: Axis.horizontal,
                  children: posts!
                      .asMap()
                      .entries
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              RecommendationCard(e.value),
                              SizedBox(
                                width: 42,
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                );
              }),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            backgroundColor: Color(0xffFFE77A),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  "Explore More",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.arrow_circle_right_outlined,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
