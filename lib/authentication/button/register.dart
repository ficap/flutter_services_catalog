import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:services_catalog/authentication/page/add_user_page.dart';

class RegisterButton extends StatelessWidget {

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Color buttonColor;

  const RegisterButton({Key? key, required this.emailController, required this.passwordController, required this.buttonColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: buttonColor,
      ),
      child: TextButton(
        onPressed: () async {
          bool shouldNavigate =
          await register(emailController.text, passwordController.text, context);
          if (shouldNavigate) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AddUserPage(),
              ),
            );
          }
        },
        child: const Text("Register", style: TextStyle(color: Colors.white)),
      ),
    );
  }
  
  static final fireAuthErrorMapping = {
    "weak-password": "The password provided is too weak",
    "email-already-in-use": "The account already exists for that email",
    "invalid-email": "Invalid email format",
  };

  Future<bool> register(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      String message = fireAuthErrorMapping[e.code] ?? "Unspecified error occurred";
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));

      return false;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}