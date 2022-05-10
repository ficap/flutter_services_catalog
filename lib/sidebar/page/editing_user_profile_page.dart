import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

import '../../authentification/ui/home_page.dart';
import '../../user/my_user.dart';
import '../widget/appbar_widget.dart';
import '../widget/profile_widget.dart';
import '../widget/text_field_widget.dart';

class EditProfilePage extends StatelessWidget {
  String imagePath;
  final Map<String, dynamic> data;
  final String uid;
  final Color buttonColor = Color.fromRGBO(77, 82, 76, 32);
  final Color textColor = Color.fromRGBO(93, 107, 89, 42);
  final Color backgroundColor = Color.fromRGBO(199, 230, 190, 90);

  EditProfilePage({Key? key, required this.data, required this.imagePath, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    nameController.text = data["name"];
    var serviceTypeController = TextEditingController();
    serviceTypeController.text = data['serviceType'];
    var aboutController = TextEditingController();
    aboutController.text = data['about'];

    String newImagePath = data['imagePath'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: textColor,
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: imagePath,
            isEdit: true,
            onClicked: () async {
              final ImagePicker _picker = ImagePicker();
              final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
              if (pickedFile != null) {
                File? photo = File(pickedFile.path);
                //
                if (photo == null) return;
                final destination = 'files/' + uid;

                try {
                  final ref = firebase_storage.FirebaseStorage.instance
                      .ref(destination + "/picture_profile")
                      .child('picture');
                  await ref.putFile(photo);
                  newImagePath = "gs://second-db-fluter.appspot.com/" + ref.fullPath;
                } catch (e) {
                  print('error occured');
                }
                //
              } else {
                print('No image selected.');
              }
              },
                ),
          const SizedBox(height: 24),
          TextFieldWidget(
            controller: data['name'],
            onChanged: (newName) {nameController.text = newName;},
          ),

          const SizedBox(height: 24),
          TextFieldWidget(
            onChanged: (speciality) {serviceTypeController.text = speciality;},
            controller: data['serviceType'],
          ),

          const SizedBox(height: 24),
          TextFieldWidget(
            controller: data['about'],
            onChanged: (about) {aboutController.text = about;},
          ),

          const SizedBox(height: 24),

          Container(
              width: 300,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: buttonColor,
              ),
              child: MaterialButton(
                  onPressed: () {
                    if (true) {
                      final user = MyUser(
                        serviceType: serviceTypeController.text,
                        name: nameController.text,
                        about: aboutController.text,
                        imagePath: newImagePath,
                      );
                      createUser(user);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    }},
                  child: Text("Save"))
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }



  Future createUser(MyUser user) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    // var idUser = auth.currentUser?.uid;
    final docUser = FirebaseFirestore.instance.collection('users').doc(uid);
    user.id = uid;
    user.email = auth.currentUser!.email.toString();
    final json = user.toJson();
    await docUser.set(json);
  }
}