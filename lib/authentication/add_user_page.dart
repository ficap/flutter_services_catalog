import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:osm_nominatim/osm_nominatim.dart';

import 'package:services_catalog/entities/provider_model.dart';
import 'package:services_catalog/my_color.dart';
import 'package:services_catalog/text_field.dart';

import 'home_page.dart';


class AddUserPage extends StatelessWidget {
  final controllerName = TextEditingController();
  final controllerServiceType = TextEditingController();
  final controllerAbout = TextEditingController();
  final controllerAddress = TextEditingController();
  final controllerPhone = TextEditingController();

  AddUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Add User'),
      automaticallyImplyLeading: false,
      backgroundColor: MyColor.textColor,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            MyTextField(controller: controllerName, hintText: "Jhon", labelText: "Name"),

            const SizedBox(height: 12),

            MyTextField(controller: controllerServiceType, hintText: "Your service offering", labelText: "Type of service"),

            const SizedBox(height: 12),

            MyTextField(controller: controllerPhone, hintText: "+420 111 222 333", labelText: "Phone"),

            const SizedBox(height: 12,),

            Container(
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: controllerAddress,
                  style: const TextStyle(color: MyColor.textColor),
                  decoration: const InputDecoration(
                    hintText: "New street 25",
                    hintStyle: TextStyle(
                      color: MyColor.textColor,
                    ),
                    labelText: "Address",
                    labelStyle: TextStyle(
                      color: MyColor.textColor,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: MyColor.textColor),
                    ),
                  ),
                ),
                suggestionsCallback: (pattern) async {
                  final searchResult = await Nominatim.searchByName(
                    query: pattern,
                    limit: 5,

                    addressDetails: true,
                    extraTags: true,
                    nameDetails: true,
                  );
                  return searchResult;
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text((suggestion as Place).displayName),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  controllerAddress.text = (suggestion as Place).displayName;
                },
                hideOnEmpty: true,
                hideOnLoading: true,
              ),
            ),

            const SizedBox(height: 12),

            MyTextField(controller: controllerAbout, hintText: "Y22 years old, programmer", labelText: "Something about you"),

            const SizedBox(height: 32),

            Container(
              width: 300,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: MyColor.buttonColor,
              ),
              child: MaterialButton(
                onPressed: () async {
                  if (controllerServiceType.text.isNotEmpty
                      && controllerName.text.isNotEmpty && controllerAddress.text.isNotEmpty) {
                    final place = await Nominatim.searchByName(
                      query: controllerAddress.text,
                      limit: 1,

                      addressDetails: true,
                      extraTags: true,
                      nameDetails: true,
                    );

                    final user = ProviderModel(
                      serviceType: controllerServiceType.text,
                      name: controllerName.text,
                      about: controllerAbout.text,
                      phone: controllerPhone.text,
                      imagePath: "gs://" +
                          FirebaseStorage.instance.ref().bucket + "/image_for_service_app/profile_image.png",
                      address: controllerAddress.text,
                      geopoint: GeoPoint(place.first.lat, place.first.lon),
                      pictureUrls: "empty"
                    );
                    createUser(user);

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Account created successfully")));
                    Navigator.of(context).popUntil(ModalRoute.withName(Navigator.defaultRouteName));
                  }},
                child: const Text("Create", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
  );

  static Future createUser(ProviderModel user) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final idUser = auth.currentUser?.uid;
    final docUser = FirebaseFirestore.instance.collection('providers').doc(idUser);
    user.id = docUser.id;
    user.email = auth.currentUser!.email.toString();
    final json = user.toJson();
    await docUser.set(json);
  }
}
