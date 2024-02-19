import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ghumfir_f/MyHomePage/Recommenadation/Recommenadation.dart';
import 'package:ghumfir_f/MyHomePage/SearchBar/SearchPart.dart';

class MyHomePage extends StatefulWidget {
  final bool isOpen;

  MyHomePage(this.isOpen);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: 8,
            sigmaY: 8,
          ),
          child: Image.asset(
            'assets/images/image_1.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.8),
          ),
        ),
        ListView(
          children: [
            Column(
              children: [
                SearchPart(widget.isOpen, () => setState(() {})),
                Container(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: const Recommenadation(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
