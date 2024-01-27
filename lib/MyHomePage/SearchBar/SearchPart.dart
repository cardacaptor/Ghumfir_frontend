import 'package:flutter/material.dart';
import 'package:ghumfir_f/Management/SearchManagement.dart';
import 'package:provider/provider.dart';

import '../../Models/user_model.dart';
import '../../api.dart';
import '../SignInScreen.dart';

class SearchPart extends StatefulWidget {
  final Function refresh;
  final bool isOpen;

  SearchPart(this.isOpen, this.refresh);

  @override
  State<SearchPart> createState() => _SearchPartState();
}

class _SearchPartState extends State<SearchPart> {
  final Color secondaryYellow = const Color(0xffFFE77A);

  final List<UserModel> users = [];

  @override
  void initState() {
    super.initState();
    Api.tokenListeners.add((prev, curr) => mounted ? setState(() {}) : 1);
  }

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
          widget.isOpen
              ? Container()
              : Image.asset(
                  "assets/images/Logo.png",
                  width: 230,
                  height: 59,
                ),
          widget.isOpen ? Container() : Expanded(child: Container()),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                hintText: "Explore your favorable travel destinations",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintStyle: TextStyle(color: Colors.white),
                filled: true,
                iconColor: Colors.white,
                fillColor: Color.fromARGB(255, 34, 33, 33),
              ),
              style: TextStyle(color: Colors.white),
              controller: context.read<SearchManagement>().controller,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: () async {
              if (Api.token == null) {
                return showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    content: const SignInScreen(),
                    backgroundColor: Color.fromARGB(255, 34, 33, 33),
                  ),
                );
              }
              _dialogBuilder(context, widget.refresh);
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.circle,
                    size: 40, color: Color.fromARGB(255, 146, 122, 16)),
                Api.user == null
                    ? Icon(
                        Icons.person_2_outlined,
                        size: 18,
                      )
                    : Text(Api.user!.username[0].toUpperCase(),
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
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
