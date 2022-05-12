import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:services_catalog/sidebar/menu/sidebar_menu.dart';
import 'package:services_catalog/sidebar/sign_in.dart';



class SideBar extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  User? user = FirebaseAuth.instance.currentUser;

  SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    var uid = user?.uid;

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return
      FutureBuilder<DocumentSnapshot>(
        future: users.doc(uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

          if (snapshot.hasError || snapshot.hasData && !snapshot.data!.exists) {
            return SignIn(padding: padding);
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return SideBarMenu(padding: padding, data: data, uid: uid);
          }

          return Text("loading");
        },
      );
  }
}
