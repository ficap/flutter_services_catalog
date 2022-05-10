import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../fire_base/fire_base.dart';
import '../page/add_user_page.dart';
import '../ui/home_page.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController emailField;
  final TextEditingController passwordField;
  final Color buttonColor;

  const LoginButton({Key? key, required this.emailField, required this.passwordField, required this.buttonColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: buttonColor,
      ),
      child: MaterialButton(
          onPressed: () async {
            bool shouldNavigate =
            await signIn(emailField.text, passwordField.text);
            if (shouldNavigate) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            }
          },
          child: Text("Login", style: TextStyle(color: Colors.white))),
    );
  }

}