import 'package:easy_search_bar/easy_search_bar.dart';
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
        left: 60,
        right: 60,
        bottom: 20,
      ),
      decoration: const BoxDecoration(
        color: Color(0x99ffffff),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/Logo.png",
            width: 230,
            height: 59,
          ),
          Expanded(child: Container()),
          Container(
            clipBehavior: Clip.hardEdge,
            width: 844,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
            ),
            child: EasySearchBar(
              title: const Text("Explore your favorable travel destinations"),
              onSearch: (String) {},
              backgroundColor: Colors.white,
              foregroundColor: Colors.grey,
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
