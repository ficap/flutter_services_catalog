import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:services_catalog/sidebar/widget/profile_widget.dart';

import '../../entities/provider_model.dart';
import '../widget/appbar_widget.dart';

class SpecialistPage extends StatelessWidget {
  static const routeName = '/provider-detail-screen';
  final ProviderModel model;

  const SpecialistPage({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    CollectionReference users = FirebaseFirestore.instance.collection('users');


    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(model.id).get(),
        builder:
        (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return Scaffold(
              appBar: buildAppBar(context),
              body: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  ProfileWidget(
                      imagePath: data['imagePath'],
                      onClicked: () {},
                      isEdit: false)
                ],
              ),
            );
          }
          return Text("loading");
        }
    );
  }

}