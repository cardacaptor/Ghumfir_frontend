
import 'package:flutter/material.dart';
import 'package:ghumfir_f/MyHomePage/Header/ContactBar.dart';
import 'package:ghumfir_f/MyHomePage/Recommenadation/Recommenadation.dart';
import 'package:ghumfir_f/MyHomePage/SearchBar/SearchPart.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              ContactBar(),
              SearchPart(),
              Recommenadation(),
            ],
          ),
        ],
      ),
    );
  }
}
