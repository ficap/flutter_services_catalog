import 'package:flutter/material.dart';
import 'package:services_catalog/fire_base/fire_base.dart';

import 'package:services_catalog/authentication/page/add_user_page.dart';

class RegisterButton extends StatelessWidget {

  final TextEditingController emailField;
  final TextEditingController passwordField;
  final Color buttonColor;

  const RegisterButton({Key? key, required this.emailField, required this.passwordField, required this.buttonColor}) : super(key: key);

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
          await register(emailField.text, passwordField.text);
          if (shouldNavigate) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AddUserPage(),
              ),
            );
          }
        },
        child: const Text("Register", style: const TextStyle(color: Colors.white)),
      ),
    );
  }

}