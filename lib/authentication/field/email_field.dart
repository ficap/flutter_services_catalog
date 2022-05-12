import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {

  final TextEditingController emailField;
  final Color textColor;

  const EmailField({Key? key, required this.emailField, required this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: TextFormField(
        style: TextStyle(color: textColor),
        controller: emailField,
        decoration: InputDecoration(
          hintText: "something@email.com",
          hintStyle: TextStyle(
            color: textColor,
          ),
          labelText: "Email",
          labelStyle: TextStyle(
            color: textColor,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: textColor),
          ),
        ),
      ),
    );
  }

}