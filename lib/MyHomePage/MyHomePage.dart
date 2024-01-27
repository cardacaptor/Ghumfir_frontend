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
        Image.asset(
          'assets/images/image_1.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Positioned.fill(
          child: Container(
            color: const Color(0x99ffffff), // Adjust color and opacity as needed
          ),
        ),
        ListView(
          children: [
            Column(
              children: [
                SearchPart(widget.isOpen, () => setState(() {})),
                const Recommenadation(),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
