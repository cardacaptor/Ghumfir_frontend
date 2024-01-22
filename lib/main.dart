import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ghumfir_f/Management/SignInManagement.dart';
import 'package:ghumfir_f/Management/SignUpManagement.dart';
import 'package:ghumfir_f/MyHomePage/MyHomePage.dart';
import 'package:ghumfir_f/MyHomePage/chat.dart';
import 'package:provider/provider.dart';

import 'api.dart';

void main() {
  Api.loadToken();
  runApp(const WrapWithProvider());
}

class WrapWithProvider extends StatelessWidget {
  const WrapWithProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignInManagement()),
        ChangeNotifierProvider(create: (_) => SignUpManagement()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ghumfir',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Builder(builder: (context) {
          return const MyApp();
        }),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isOpen = false;
  double minWidth = 200;
  double maxDelta = 300;
  double delta = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isOpen
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: MyHomePage()),
                MouseRegion(
                  cursor: SystemMouseCursors.resizeColumn,
                  child: GestureDetector(
                    onHorizontalDragUpdate: (dg) => setState(() {
                      delta -= dg.delta.dx;
                      if (delta < 0) delta = 0;
                      if (delta > maxDelta) delta = maxDelta;
                    }),
                    child: Container(
                      width: 4,
                      height: double.infinity,
                      color: Colors.red,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isOpen = false;
                    });
                  },
                  child: Icon(
                    Icons.close,
                    size: 30,
                  ),
                ),
                SizedBox(
                  width: minWidth + delta,
                  child: ChatScreen(),
                ),
              ],
            )
          : Stack(
              children: [
                MyHomePage(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.all(0),
                    width: 50,
                    height: 114,
                    child: IconButton(
                      icon: Icon(Icons.message),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffFFE77A),
                      ),
                      onPressed: () {
                        setState(() {
                          isOpen = !isOpen;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
