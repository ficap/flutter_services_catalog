import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:services_catalog/authentification/ui/home_page.dart';

import '../../user/my_user.dart';

class AddUserPage extends StatefulWidget {
  AddUserPage({Key? key}) : super(key: key);

  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final controllerName = TextEditingController();
  final controllerServiceType = TextEditingController();
  final controllerAbout = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
    body: ListView(
      padding: EdgeInsets.all(16),
      children: <Widget>[
        TextField(
          controller: controllerName,
          decoration: decoration('Name'),
        ),
        const SizedBox(height: 24),
        TextField(
          controller: controllerServiceType,
          decoration: decoration('Type of service'),
        ),
        const SizedBox(height: 24),
        TextField(
          controller: controllerAbout,
          decoration: decoration('Something about you'),
        ),
        const SizedBox(height: 32),
        ElevatedButton(
            onPressed: () {
              // TODO bad updating implementation 
              if (!controllerServiceType.text.isEmpty
              && !controllerName.text.isEmpty) {
                final user = MyUser(
                  serviceType: controllerServiceType.text,
                  name: controllerName.text,
                  about: controllerAbout.text,
                  imagePath: "gs://second-db-fluter.appspot.com/image_for_service_app/profile_image.png",
                );
                createUser(user);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              }
            },
            child: Text('Create')
        ),
      ],
    ),
    );

  InputDecoration decoration(String lable) => InputDecoration(
    labelText: lable,
    border: OutlineInputBorder(),
  );

  Future createUser(MyUser user) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var idUser = auth.currentUser?.uid;
    final docUser = FirebaseFirestore.instance.collection('users').doc(idUser);
    user.id = docUser.id;
    user.email = auth.currentUser!.email.toString();
    final json = user.toJson();
    await docUser.set(json);
  }
}
