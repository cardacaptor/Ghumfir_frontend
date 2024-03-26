import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ghumfir_f/MyHomePage/Recommenadation/landings/Explore.dart';
import 'package:ghumfir_f/MyHomePage/Recommenadation/landings/Recommenadation.dart';
import 'package:ghumfir_f/MyHomePage/Recommenadation/landings/Trending.dart';
import 'package:ghumfir_f/MyHomePage/SearchBar/SearchPart.dart';
import 'package:ghumfir_f/api.dart';

class MyHomePage extends StatefulWidget {
  final bool isOpen;

  MyHomePage(this.isOpen);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  bool isForYou = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      isForYou = Api.token != null;
    });
    Api.tokenListeners.add((_, String? currToken) {
      if (mounted) {
        setState(() {
          isForYou = currToken != null;
        });
      }
    });
  }

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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Column(
                          children: [
                            Container(height: 20),
                            Builder(builder: (context) {
                              List<String> navTabBars = [
                                "Explore",
                                if (isForYou) "For you",
                                "Trending"
                              ];
                              return Column(
                                children: navTabBars
                                    .asMap()
                                    .entries
                                    .map(
                                      (element) => GestureDetector(
                                        onTap: () => setState(
                                            () => currentIndex = element.key),
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: element.key ==
                                                    min(currentIndex,
                                                        navTabBars.length - 1)
                                                ? Colors.green
                                                : null,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 12),
                                          child: Text(
                                            element.value,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              );
                            }),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Builder(builder: (context) {
                          List<Widget> widgets = [
                            const Explore(),
                            if (isForYou) const Recommenadation(),
                            const Trending(),
                          ];
                          return IndexedStack(
                            index: min(currentIndex, widgets.length - 1),
                            children: widgets,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
