import 'package:flutter/material.dart';

class HeaderFile extends StatelessWidget {
  final Color secondaryYellow = Color(0xffFFE77A);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      height: 140,
      decoration: const BoxDecoration(
        color: Color(0x99ffffff),
      ),
      child: Column(
        children: [
          Image.asset(
            "assets/images/Logo.png",
            width: 230,
            height: 59,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: Row(
              children: [
                // Stack(
                //   children: [
                //     Icon(
                //       Icons.circle,
                //       size: 40,
                //       color: secondaryYellow,
                //     ),
                //     const Positioned(
                //       left: 0,
                //       bottom: 0,
                //       right: 0,
                //       top: 0,
                //       child: Icon(
                //         Icons.search,
                //         size: 18,
                //       ),
                //     ),
                //   ],
                // ),
                Expanded(child: Container()),
                Center(
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 40,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Text(
                        "Destinations",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      // SizedBox(
                      //   width: 40,
                      // ),
                      // Text(
                      //   "Our Story",
                      //   style: TextStyle(
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.w400,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Expanded(child: Container()),
                Stack(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 40,
                      color: secondaryYellow,
                    ),
                    const Positioned(
                      left: 0,
                      bottom: 0,
                      right: 0,
                      top: 0,
                      child: Icon(
                        Icons.person_2_outlined,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
