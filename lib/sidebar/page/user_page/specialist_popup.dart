import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:services_catalog/sidebar/widget/user_widget/profile_widget.dart';

import 'package:services_catalog/entities/provider_model.dart';

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
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return Scaffold(
              appBar: buildAppBar(context),
              body: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  ProfileWidget(
                      imagePath: data['imagePath'],
                      onClicked: () {},
                      isEdit: false)
                ],
              ),
            );
          }
          return const Text("loading");
        }
    );
  }

  AppBar buildAppBar(BuildContext context) {
    final icon = CupertinoIcons.moon_stars;

    return AppBar(
      leading: const BackButton(),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        IconButton(
          icon: Icon(icon),
          onPressed: () {},
        ),
      ],
    );
  }
}