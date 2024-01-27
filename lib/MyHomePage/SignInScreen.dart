import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ghumfir_f/MyHomePage/SignUpScreen.dart';
import 'package:hovering/hovering.dart';
import 'package:provider/provider.dart';

import '../Components/TextField.dart';
import '../Management/SignInManagement.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignInManagement read = context.read<SignInManagement>();
    SignInManagement watch = context.watch<SignInManagement>();
    return Container(
      width: 600,
      height: 550,
      // color: Theme.of(context).colorScheme.background,
      child: Center(
        child: Row(
          children: [
            Expanded(child: Container()),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sign In",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "And unlock chat with our intelligent bot and streamline your experience effortlessly",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PersonalTextField(
                      controller: read.usernameController,
                      errorText: watch.isConfirmButtonPressed
                          ? watch.usernameError
                          : null,
                      labelText: "Username",
                      onChanged: (String? input) {
                        read.validate();
                      },
                    ),
                    PersonalTextField(
                      controller: read.passwordController,
                      errorText: watch.isConfirmButtonPressed
                          ? watch.passwordError
                          : null,
                      labelText: 'Password',
                      obscureText: watch.isPasswordVisible ? false : true,
                      icon: GestureDetector(
                        onTap: () {
                          read.isPasswordVisible = !read.isPasswordVisible;
                        },
                        child: Icon(watch.isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      onChanged: (String? input) {
                        read.validate();
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await read.logInToAccount(context);
                      },
                      child: HoverContainer(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                        color: watch.createButtonEnabled
                            ? Color(0xff2c5f2d)
                            : Colors.blueGrey,
                        hoverColor: Color.fromARGB(255, 52, 112, 53),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Log in to the Account",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // context.read<UserManagement>().setindex(1, context);
                            showDialog(
                                barrierColor: null,
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    content: SignUpScreen(),
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  );
                                });
                          },
                          child: HoverWidget(
                            onHover: (PointerEnterEvent event) {},
                            hoverChild: Text(
                              "Signup",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff2c5f2d),
                              ),
                            ),
                            child: Text(
                              "Signup",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
