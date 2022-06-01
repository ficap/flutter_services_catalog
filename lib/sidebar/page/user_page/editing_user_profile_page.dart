import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:services_catalog/authentication/add_user_page.dart';
import 'package:services_catalog/di.dart';
import 'package:services_catalog/entities/provider_model.dart';
import 'package:services_catalog/fire_base/storage.dart';
import 'package:services_catalog/my_color.dart';

import 'package:services_catalog/sidebar/widget/user_widget/profile_widget.dart';
import 'package:services_catalog/text_field.dart';

class EditProfilePage extends StatelessWidget {
  final String imagePath;
  final Storage storage = Storage();


  EditProfilePage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: MyColor.textColor,
      ),
      body: StreamBuilder<ProviderModel?>(
          stream: Provider.of<DI>(context).currentUserStream,
          builder: (context, snapshot) {

            final providerModel = snapshot.data!;

            final nameController = TextEditingController();
            nameController.text = providerModel.name;
            final serviceTypeController = TextEditingController();
            serviceTypeController.text = providerModel.serviceType;
            final aboutController = TextEditingController();
            aboutController.text = providerModel.about;
            String newImagePath = providerModel.imagePath;
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              physics: const BouncingScrollPhysics(),
              children: [
                ProfileWidget(
                  imagePath: imagePath,
                  isEdit: true,
                  onClicked: () async {

                    print(FirebaseStorage.instance.ref().bucket);
                    final destination = 'files/' + providerModel.id + "/picture_profile";
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
                            builder: (context) => EditProfilePage(imagePath: newImagePath)));
                  },
                ),
                const SizedBox(height: 24),

                MyTextField(controller: nameController, hintText: nameController.text, labelText: "Name"),

                const SizedBox(height: 24),

                MyTextField(controller: serviceTypeController, hintText: serviceTypeController.text, labelText: "Type of service"),

                const SizedBox(height: 24),

                MyTextField(controller: aboutController, hintText: aboutController.text, labelText: "About"),

                const SizedBox(height: 24),

                Container(
                    width: 300,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: MyColor.textColor,
                    ),
                    child: MaterialButton(
                        onPressed: () {
                          if (true) {
                            final user = ProviderModel(
                              serviceType: serviceTypeController.text,
                              name: nameController.text,
                              about: aboutController.text,
                              imagePath: imagePath,
                              pictureUrls: providerModel.pictureUrls
                            );
                            AddUserPage.createUser(user);

                            Navigator.of(context).pop();
                          }},
                        child: const Text("Save"))
                ),
                const SizedBox(height: 24),
              ],
            );
        }
      ),
    );
  }
}