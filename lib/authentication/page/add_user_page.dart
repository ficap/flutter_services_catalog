import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:osm_nominatim/osm_nominatim.dart';
import 'package:services_catalog/authentication/page/home_page.dart';

import 'package:services_catalog/authentication/field/add_uder_field_controller.dart';
import 'package:services_catalog/entities/provider_model.dart';


class AddUserPage extends StatelessWidget {
  final controllerName = TextEditingController();
  final controllerServiceType = TextEditingController();
  final controllerAbout = TextEditingController();
  final controllerAddress = TextEditingController();
  final controllerPhone = TextEditingController();
  final Color textColor = const Color.fromRGBO(93, 107, 89, 42);
  final Color backgroundColor = const Color.fromRGBO(199, 230, 190, 90);
  final Color buttonColor = const Color.fromRGBO(77, 82, 76, 32);

  AddUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Add User'),
      automaticallyImplyLeading: false,
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
          const SizedBox(height: 12),

          AddUserFieldController(controller: controllerServiceType, textColor: textColor, hintText: "Your service offering", lableText: "Type of service"),
          const SizedBox(height: 12),

      Container(
        padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
        child: TextFormField(
          style: TextStyle(color: textColor),
          controller: controllerPhone,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: "+420 111 222 333",
            hintStyle: TextStyle(
              color: textColor,
            ),
            labelText: "Phone",
            labelStyle: TextStyle(
              color: textColor,
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: textColor),
            ),
          ),
        ),
      ),

          const SizedBox(height: 12,),

          Container(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: controllerAddress,
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  hintText: "New street 25",
                  hintStyle: TextStyle(
                    color: textColor,
                  ),
                  labelText: "Address",
                  labelStyle: TextStyle(
                    color: textColor,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: textColor),
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

          AddUserFieldController(controller: controllerAbout, textColor: textColor, hintText: "Y22 years old, programmer", lableText: "Something about you"),
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
                    && controllerName.text.isNotEmpty && controllerAddress.text.isNotEmpty) {
                  var place = await Nominatim.searchByName(
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
                    geopoint: GeoPoint(place.first.lat, place.first.lon)
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
    var idUser = auth.currentUser?.uid;
    final docUser = FirebaseFirestore.instance.collection('providers').doc(idUser);
    user.id = docUser.id;
    user.email = auth.currentUser!.email.toString();
    final json = user.toJson();
    await docUser.set(json);
  }
}
