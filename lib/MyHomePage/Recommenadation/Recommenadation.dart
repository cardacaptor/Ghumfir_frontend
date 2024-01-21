import 'package:flutter/material.dart';
import 'package:ghumfir_f/MyHomePage/Recommenadation/RecommendationCard.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api.dart';

class Recommenadation extends StatelessWidget {
  const Recommenadation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Api.token = null;
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
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 70, vertical: 20),
            scrollDirection: Axis.horizontal,
            children: [
              ["", 1],
              ["", 2],
              ["", 3],
              ["", 4]
            ]
                .asMap()
                .entries
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        RecommendationCard(e.value[1] as int),
                        SizedBox(
                          width: 42,
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
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
