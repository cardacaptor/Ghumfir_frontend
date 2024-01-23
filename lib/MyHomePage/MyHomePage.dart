import 'package:flutter/material.dart';
import 'package:ghumfir_f/MyHomePage/Recommenadation/Recommenadation.dart';
import 'package:ghumfir_f/MyHomePage/SearchBar/SearchPart.dart';

class MyHomePage extends StatelessWidget {
  final bool isOpen;
  MyHomePage(this.isOpen);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/image_1.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Positioned.fill(
          child: Container(
            color: Color(0x99ffffff), // Adjust color and opacity as needed
          ),
        ),
        ListView(
          children: [
            Column(
              children: [
                SearchPart(isOpen),
                Recommenadation(),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
