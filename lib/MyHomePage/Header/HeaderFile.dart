import 'package:flutter/material.dart';
import 'package:ghumfir_f/Models/user_model.dart';

class HeaderFile extends StatelessWidget {
  final Color secondaryYellow = Color(0xffFFE77A);
  final List<UserModel> users = [];

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
                    children: [
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
                InkWell(
                  onTap: () {
                    _dialogBuilder(context);
                  },
                  child: Stack(
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _dialogBuilder(BuildContext context) {
    return showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Basic dialog title'),
          content: const Text(
            'A dialog is a type of modal window that\n'
            'appears in front of app content to\n'
            'provide critical information, or prompt\n'
            'for a decision to be made.',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Disable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Enable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
