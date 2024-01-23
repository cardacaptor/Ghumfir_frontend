import 'package:flutter/material.dart';

class DialogPrompt {
  static showSnackbar(String text, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color(0xff2f2f2f),
        duration: Duration(seconds: 5),
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.info,
              color: Colors.white,
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
                child: Text(
              text,
              style: TextStyle(color: Colors.white),
            )),
          ],
        ),
      ),
    );
  }
}
