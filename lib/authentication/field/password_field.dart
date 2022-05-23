import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {

  final TextEditingController passwordField;
  final Color textColor;

  const PasswordField({Key? key, required this.passwordField, required this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: textColor),
      controller: passwordField,
      obscureText: true,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: textColor),
        ),
        hintText: "password",
        hintStyle: TextStyle(
          color: textColor,
        ),
        labelText: "Password",
        labelStyle: TextStyle(
          color: textColor,
        ),

      ),
    );
  }

}