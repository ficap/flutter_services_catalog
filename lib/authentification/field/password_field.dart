import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {

  final TextEditingController passwordField;

  const PasswordField({Key? key, required this.passwordField}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.3,
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        controller: passwordField,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: "password",
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          labelText: "Password",
          labelStyle: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

}