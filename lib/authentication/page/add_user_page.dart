import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:services_catalog/authentication/page/home_page.dart';

import 'package:services_catalog/authentication/entities/my_user.dart';
import 'package:services_catalog/authentication/field/add_uder_field_controller.dart';


class AddUserPage extends StatelessWidget {
  final controllerName = TextEditingController();
  final controllerServiceType = TextEditingController();
  final controllerAbout = TextEditingController();
  final Color textColor = const Color.fromRGBO(93, 107, 89, 42);
  final Color backgroundColor = const Color.fromRGBO(199, 230, 190, 90);
  final Color buttonColor = const Color.fromRGBO(77, 82, 76, 32);

  AddUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Add User'),
      backgroundColor: textColor,
    ),
    body: Container(
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          AddUserFieldController(controller: controllerName, textColor: textColor, hintText: "Jhon", lableText: "Name"),
          //
          const SizedBox(height: 24),

          AddUserFieldController(controller: controllerServiceType, textColor: textColor, hintText: "Your service offering", lableText: "Type of service"),
          //
          const SizedBox(height: 24),
          //
          AddUserFieldController(controller: controllerAbout, textColor: textColor, hintText: "Y22 years old, programmer", lableText: "Something about you"),
          //
          const SizedBox(height: 32),

          Container(
            width: 300,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: buttonColor,
            ),
            child: MaterialButton(
              onPressed: () async {
                if (controllerServiceType.text.isNotEmpty
                    && controllerName.text.isNotEmpty) {
                  final user = MyUser(
                    serviceType: controllerServiceType.text,
                    name: controllerName.text,
                    about: controllerAbout.text,
                    imagePath: "gs://" +
                        FirebaseStorage.instance.ref().bucket + "/image_for_service_app/profile_image.png",
                  );
                  createUser(user);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                }},
              child: const Text("Create", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    ),
  );

  static Future createUser(MyUser user) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var idUser = auth.currentUser?.uid;
    final docUser = FirebaseFirestore.instance.collection('users').doc(idUser);
    user.id = docUser.id;
    user.email = auth.currentUser!.email.toString();
    final json = user.toJson();
    await docUser.set(json);
  }
}
