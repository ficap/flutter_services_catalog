
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../fire_base/fire_base.dart';
import '../page/add_user_page.dart';
import '../ui/home_page.dart';

class RegisterButton extends StatelessWidget {

  final TextEditingController emailField;
  final TextEditingController passwordField;

  const RegisterButton({Key? key, required this.emailField, required this.passwordField}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      child: MaterialButton(
        onPressed: () async {
          bool shouldNavigate =
          await register(emailField.text, passwordField.text);
          if (shouldNavigate) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddUserPage(),
              ),
            );
          }
        },
        child: Text("Register"),
      ),
    );
  }

}