import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:services_catalog/authentication/field/email_field.dart';
import 'package:services_catalog/authentication/field/password_field.dart';
import 'package:services_catalog/authentication/page/add_user_page.dart';
import 'package:services_catalog/fire_base/fire_base.dart';


class AuthenticationScreen extends StatefulWidget {
  static String id = "authentication";
  final Color buttonColor = const Color.fromRGBO(77, 82, 76, 32);
  final Color textColor = const Color.fromRGBO(93, 107, 89, 42);
  final Color backgroundColor = const Color.fromRGBO(199, 230, 190, 90);

  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;

  set loading(bool value) => setState(() {
    _loading = value;
  });

  bool get loading => _loading;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Authentication"),
      ),
      // backgroundColor: widget.backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),

        child: Column(
          children: [
            EmailField(
              emailField: _emailController, 
              textColor: widget.textColor,
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 35),

            PasswordField(
              passwordField: _passwordController, 
              textColor: widget.textColor,
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 30),

            TextButton(
              onPressed: trySignIn,
              child: const Text("Sign In"),
            ),

            TextButton(
              onPressed: tryRegister,
              child: const Text("Register"),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 35),

            if (_loading) const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  static final _fireAuthErrorMapping = {
    "weak-password": "The password provided is too weak",
    "email-already-in-use": "The account already exists for that email",
    "invalid-email": "Invalid email format",
  };

  void trySignIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    loading = true;
    var success = await signIn(email, password);
    loading = false;
    if(!success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid login")));
      return;
    }
    Navigator.of(context).pop();
  }

  void tryRegister() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    loading = true;
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      loading = false;
      String message = _fireAuthErrorMapping[e.code] ?? "Unspecified error occurred";
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      return;
    }

    loading = false;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => AddUserPage()),
    );
  }
}