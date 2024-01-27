import 'package:flutter/material.dart';
import 'package:ghumfir_f/Management/SearchManagement.dart';
import 'package:provider/provider.dart';

import '../../Models/user_model.dart';
import '../../api.dart';
import '../SignInScreen.dart';

class SearchPart extends StatelessWidget {
  final Color secondaryYellow = const Color(0xffFFE77A);
  final List<UserModel> users = [];
  final Function refresh;
  final bool isOpen;

  SearchPart(this.isOpen, this.refresh);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
        left: 60,
        right: 60,
        bottom: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
      ),
      child: Row(
        children: [
          isOpen
              ? Container()
              : Image.asset(
                  "assets/images/Logo.png",
                  width: 230,
                  height: 59,
                ),
          isOpen ? Container() : Expanded(child: Container()),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Explore your favorable travel destinations",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              controller: context.read<SearchManagement>().controller,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: () async {
              if(Api.token == null){
                return showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    content: const SignInScreen(),
                    backgroundColor: Theme.of(context).colorScheme.background,
                  ),
                );
              }
              _dialogBuilder(context, refresh);
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

  Future<dynamic> _dialogBuilder(BuildContext context, Function refresh) {
    return showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Do you want to logout'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Yes'),
              onPressed: () async {
                await Api.setToken(null);
                refresh();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
