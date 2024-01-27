import 'package:flutter/material.dart';
import 'package:ghumfir_f/Management/SignInManagement.dart';
import 'package:ghumfir_f/Management/SignUpManagement.dart';
import 'package:ghumfir_f/MyHomePage/MyHomePage.dart';
import 'package:ghumfir_f/MyHomePage/chat.dart';
import 'package:provider/provider.dart';

import 'Management/SearchManagement.dart';
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
        ChangeNotifierProvider(create: (_) => SearchManagement()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ghumfir',
        theme: ThemeData(
          primarySwatch: Colors.green,
          textTheme: TextTheme(
            bodyMedium: TextStyle(color: Colors.white),
          ),
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
  double minWidth = 300;
  double maxDelta = 500;
  double delta = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Stack(
            children: [
              MyHomePage(isOpen),
              if (!isOpen)
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 50,
                    height: 114,
                    child: Material(
                      color: Color(0xffFFE77A),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                        ),
                        onTap: () => setState(() => isOpen = !isOpen),
                        child: IconButton(
                          icon: Icon(
                            Icons.message,
                            color: Colors.black,
                          ),
                          onPressed: () => setState(() => isOpen = !isOpen),
                          color: Color(0xffFFE77A),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          )),
          AnimatedContainer(
            color: Color.fromARGB(255, 34, 33, 33),
            duration: Duration(milliseconds: 200),
            width: isOpen ? (minWidth + delta + 6) : 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MouseRegion(
                  cursor: SystemMouseCursors.resizeColumn,
                  child: GestureDetector(
                    onHorizontalDragUpdate: (dg) => setState(() {
                      delta -= dg.delta.dx;
                      if (delta < 0) delta = 0;
                      if (delta > maxDelta) delta = maxDelta;
                    }),
                    child: Container(
                      width: 6,
                      height: double.infinity,
                      color: Color(0xff2c5f2d),
                    ),
                  ),
                ),
                Stack(
                  children: [
                    SizedBox(
                      width: minWidth + delta,
                      child: ChatScreen(),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => isOpen = false),
                      child: Icon(
                        Icons.close,
                        size: 30,
                        color: Colors.white,
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
