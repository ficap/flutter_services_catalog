import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../button/login.dart';
import '../button/register.dart';
import '../field/email_field.dart';
import '../field/password_field.dart';
import 'home_page.dart';



class Authentication extends StatelessWidget {
  static String id = "authentication";
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();
  final Color buttonColor = Color.fromRGBO(77, 82, 76, 32);
  final Color textColor = Color.fromRGBO(93, 107, 89, 42);
  final Color backgroundColor = Color.fromRGBO(199, 230, 190, 90);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EmailField(emailField: _emailField, textColor: textColor),

            SizedBox(height: MediaQuery.of(context).size.height / 35),

            PasswordField(passwordField: _passwordField, textColor: textColor),

            SizedBox(height: MediaQuery.of(context).size.height / 35),

            RegisterButton(emailField: _emailField, passwordField: _passwordField, buttonColor: buttonColor),

            SizedBox(height: MediaQuery.of(context).size.height / 35),

            LoginButton(emailField: _emailField, passwordField: _passwordField, buttonColor: buttonColor),


          ],
        ),
      ),
    );
  }
}