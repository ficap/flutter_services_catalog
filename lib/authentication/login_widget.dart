import 'package:flutter/material.dart';
import 'package:services_catalog/authentication/button/register.dart';
import 'package:services_catalog/fire_base/fire_base.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _loading = false;

  set loading(bool value) => setState(() {
    _loading = value;
  });

  bool get loading => _loading;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          TextField(
            controller: emailController,
            textInputAction: TextInputAction.next,
            autofocus: true,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: "Email"
            ),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: passwordController,
            textInputAction: TextInputAction.done,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Password"
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50)
            ),
            icon: const Icon(Icons.login, size: 32),
            label: const Text(
              'Sign In',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: () {
              trySignIn(
                emailController.text.trim(),
                passwordController.text.trim(),
              );
            },
          ),
          // todo: display register errors and utilize progressbar
          RegisterButton(emailController: emailController, passwordController: passwordController, buttonColor: Colors.amber),
          const SizedBox(height: 20),
          if (loading)
            const CircularProgressIndicator()
        ],
      ),
    );
  }

  void trySignIn(String email, String password) async {
    loading = true;
    var success = await signIn(email, password);
    loading = false;
    if(!success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid login")));
      return;
    }
    Navigator.of(context).pop();
  }
}