import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../button/login.dart';
import '../button/register.dart';
import '../field/email_field.dart';
import '../field/password_field.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.blueAccent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EmailField(emailField: _emailField),

            SizedBox(height: MediaQuery.of(context).size.height / 35),

            PasswordField(passwordField: _passwordField),

            SizedBox(height: MediaQuery.of(context).size.height / 35),

            RegisterButton(emailField: _emailField, passwordField: _passwordField),

            SizedBox(height: MediaQuery.of(context).size.height / 35),

            LoginButton(emailField: _emailField, passwordField: _passwordField)
          ],
        ),
      ),
    );
  }
}