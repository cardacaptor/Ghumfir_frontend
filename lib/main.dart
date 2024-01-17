import 'package:flutter/material.dart';
import 'package:ghumfir_f/MyHomePage/MyHomePage.dart';
import 'package:ghumfir_f/MyHomePage/chat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ghumfir',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isOpen
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: MyHomePage()),
                SizedBox(
                  width: 4,
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
                Expanded(child: ChatScreen()),
              ],
            )
          : Stack(
              children: [
                MyHomePage(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.only(right: 0),
                    width: 50,
                    height: 114,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xffFFE77A),
                      ),
                      onPressed: () {
                        setState(() {
                          isOpen = !isOpen;
                        });
                      },
                      child: Icon(Icons.message),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
