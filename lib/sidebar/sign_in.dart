import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:services_catalog/authentication/page/authentification.dart';
import 'package:services_catalog/sidebar/menu/head_item.dart';

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
            HeadItem(
              padding: padding,
              urlImage: "gs://" + FirebaseStorage.instance.ref().bucket + "/image_for_service_app/profile_image.png",
              name: "Sign in",
              email: "",
              onClicked: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Authentication()
              )),
            )
          ],
        ),

      ),
    );
  }

}