import 'package:firebase_image/firebase_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:services_catalog/authentication/authentification.dart';


class SignIn extends StatelessWidget {
  final EdgeInsets padding;

  const SignIn({Key? key, required this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: const Color.fromRGBO(199, 230, 190, 90),
        child: ListView(
          children: <Widget>[
            InkWell(
              onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const AuthenticationScreen())),
              child: Container(
                padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
                child: Row(
                  children: [
                    CircleAvatar(radius: 30, backgroundImage: FirebaseImage("gs://" + FirebaseStorage.instance.ref().bucket + "/image_for_service_app/profile_image.png")),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Sign in",
                          style: TextStyle(fontSize: 20, color: Color.fromRGBO(93, 107, 89, 42)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

      ),
    );
  }

}