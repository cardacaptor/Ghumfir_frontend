import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Header/HeaderFile.dart';

class SearchPart extends StatelessWidget {
  const SearchPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/images/image_1.png',
            height: 640,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover),
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: HeaderFile(),
        ),
        Positioned(
          top: 320,
          right: 0,
          left: 0,
          child: Column(
            children: [
              Text(
                "Explore your favorable travel destinations",
                style: GoogleFonts.rufina(
                  textStyle: const TextStyle(
                    fontSize: 42,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                clipBehavior: Clip.hardEdge,
                width: 844,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: EasySearchBar(
                  title: const Text("Explore Now"),
                  onSearch: (String) {},
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
