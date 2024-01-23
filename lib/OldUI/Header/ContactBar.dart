import 'package:flutter/material.dart';

class ContactBar extends StatelessWidget {

  final Color secondaryYellow = Color(0xffFFE77A);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        right: 80,
      ),
      height: 40,
      decoration: const BoxDecoration(
        color: Color(0xff2c5f2d),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(),
          ),
          Icon(
            Icons.call,
            color: secondaryYellow,
            size: 15,
          ),
          const SizedBox(
            width: 5,
          ),
          const Text(
            "+977 7894561230",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
           Icon(
            Icons.circle,
            color: secondaryYellow,
            size: 5,
          ),
          const SizedBox(
            width: 10,
          ),
           Icon(
            Icons.mail,
            color: secondaryYellow,
            size: 15,
          ),
          const SizedBox(
            width: 5,
          ),
          const Text(
            "infoghumfir@gmail.com",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
