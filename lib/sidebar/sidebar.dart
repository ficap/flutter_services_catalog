import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:services_catalog/authentification/ui/authentification.dart';

import 'page/setting_page.dart';
import 'page/user_profil_page.dart';


class SideBar extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  User? user = FirebaseAuth.instance.currentUser;

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
            // return Text("Something went wrong");
            return Drawer(
              child: Material(
                color: Color.fromRGBO(199, 230, 190, 90),
                child: ListView(
                  children: <Widget>[
                    buildHeader(
                      urlImage: "gs://" + FirebaseStorage.instance.ref().bucket + "/image_for_service_app/profile_image.png",
                      name: "Sign in",
                      email: "",
                      onClicked: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => Authentication()
                      )),
                    ),
                  ],
                ),

              ),
            );
          }

          // if (snapshot.hasData && !snapshot.data!.exists) {
          //   return Text("Document does not exist");
          // }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return Drawer(
              child: Material(
                color: Color.fromRGBO(199, 230, 190, 90),
                child: ListView(
                  children: <Widget>[
                    buildHeader(
                      urlImage: data['imagePath'],
                      name: data['name'],
                      email: data['email'],
                      onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UserPage(
                          imagePath: data['imagePath'],
                          data: data,
                          uid: uid!,
                        ),
                      )),
                    ),
                    Container(
                      padding: padding,
                      child: Column(
                        children: [
                          SizedBox(height: 12),
                          buildMenuItem(
                            text: 'Logout',
                            icon: Icons.logout,
                            onClicked: () => {
                              FirebaseAuth.instance.signOut(),
                              Navigator.of(context).pop()
                            }
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

              ),
            );
          }

          return Text("loading");
        },
      );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: FirebaseImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Color.fromRGBO(93, 107, 89, 42)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(fontSize: 14, color: Color.fromRGBO(93, 107, 89, 42)),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Color.fromRGBO(93, 107, 89, 42);
    final hoverColor = Color.fromRGBO(93, 107, 89, 42);

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SettingPage(),
        ));
        break;
    }
  }
}
