import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {

  final TextEditingController emailField;

  const EmailField({Key? key, required this.emailField}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: emailField,
        decoration: const InputDecoration(
          hintText: "something@email.com",
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          labelText: "Email",
          labelStyle: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

}