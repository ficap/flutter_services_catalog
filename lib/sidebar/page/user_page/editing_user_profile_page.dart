
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:services_catalog/authentication/page/add_user_page.dart';
import 'package:services_catalog/authentication/page/home_page.dart';
import 'package:services_catalog/entities/provider_model.dart';
import 'package:services_catalog/fire_base/storage.dart';

import 'package:services_catalog/sidebar/widget/user_widget/profile_widget.dart';
import 'package:services_catalog/sidebar/widget/user_widget/text_field_widget.dart';

class EditProfilePage extends StatelessWidget {
  String imagePath;
  final Map<String, dynamic> data;
  final String uid;
  final Storage storage = Storage();
  final Color buttonColor = const Color.fromRGBO(77, 82, 76, 32);
  final Color textColor = const Color.fromRGBO(93, 107, 89, 42);
  final Color backgroundColor = const Color.fromRGBO(199, 230, 190, 90);

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
        title: const Text('Edit Profile'),
        backgroundColor: textColor,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: imagePath,
            isEdit: true,
            onClicked: () async {

              print(FirebaseStorage.instance.ref().bucket);
              final destination = 'files/' + uid + "/picture_profile";
              final results = await FilePicker.platform.pickFiles(
                allowMultiple: false,
                type: FileType.custom,
                allowedExtensions: ['png', 'jpg'],
              );
              if (results == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('No file selected'),
                  ),
                );
                return;
              }
              final path = results.files.single.path!;
              final fileName = results.files.single.name;

              newImagePath = "gs://" +
                  FirebaseStorage.instance.ref().bucket + "/" + destination + "/" + fileName;
              storage
                  .uploadFile(path, destination, fileName)
                  .then((value) => print('Done'));
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                  builder: (context) => EditProfilePage(data: data, imagePath: newImagePath, uid: uid,)));
              },
                ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Name',
            text: data['name'],
            onChanged: (newName) {nameController.text = newName;},
          ),

          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Type of service',
            text: data['serviceType'],
            onChanged: (speciality) {serviceTypeController.text = speciality;},
          ),

          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'About',
            text: data['about'],
            maxLines: 10,
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
                      final user = ProviderModel(
                        serviceType: serviceTypeController.text,
                        name: nameController.text,
                        about: aboutController.text,
                        imagePath: imagePath,
                      );
                      AddUserPage.createUser(user);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    }},
                  child: const Text("Save"))
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

}