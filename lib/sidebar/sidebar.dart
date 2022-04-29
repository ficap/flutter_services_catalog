import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';
import 'package:services_catalog/flutter_map_firestore.dart';

import '../authentification/entities/provider_user_data.dart';
import '../authentification/page/add_user_page.dart';
import 'page/setting_page.dart';
import 'page/user_profil_page.dart';


class SideBar extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  String name = '';
  String serviceType = '';
  String email = '';
  User? user = FirebaseAuth.instance.currentUser;
  String about = '';

  @override
  Widget build(BuildContext context) {
    // final email = 'mark@facebook.com';
    // final urlImage =
    //     'https://upload.wikimedia.org/wikipedia/commons/1/18/Mark_Zuckerberg_F8_2019_Keynote_%2832830578717%29_%28cropped%29.jpg';


    // final _providerUserDataCollection = FirebaseFirestore.instance
    //     .collection('users').withConverter<ProviderUserDataModel>(
    //   fromFirestore: (document, options) => ProviderUserDataModel.fromJson(document.data()!),
    //   toFirestore: (model, options) => model.toJson(),
    // );

    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    var uid = user?.uid;

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return
      FutureBuilder<DocumentSnapshot>(
        future: users.doc(uid).get(),
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
            return Drawer(
              child: Material(
                color: Color.fromRGBO(50, 75, 205, 1),
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
                          const SizedBox(height: 12),
                          buildMenuItem(
                            text: 'Settings',
                            icon: Icons.settings,
                            onClicked: () => selectedItem(context, 0),
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


  // Widget _createUserInfo (
  //     DocumentSnapshot<Object?> document, BuildContext context) {
    // ProviderUserDataModel userData =
    // ProviderUserDataModel.fromJson(document.data()! as Map<String, dynamic>);
    // return Container(
    //   child: ListTile(
    //     title: Text(userData.name),
    //     subtitle: Text(userData.addedBy),
    //     trailing: const Icon(Icons.arrow_forward_ios),
    //     onTap: () {
    //       Navigator.of(context).push(
    //         MaterialPageRoute(
    //           builder: (_) => MovieDetail(
    //             movieModel: userData,
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );
  // }

  readData() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    var uid = user?.uid;

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    var specificUserInfo = users.doc(uid).get();

    Stream documentStream = FirebaseFirestore.instance.collection('users').doc(uid).snapshots();

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        name = documentSnapshot.get('name');
        print(documentSnapshot.get('name'));
      }
    });

    // FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(uid)
    //     .get()
    //     .then((DocumentSnapshot documentSnapshot) {
    //   if (documentSnapshot.exists) {
    //     print('Document data: ${documentSnapshot.data()}');
    //   } else {
    //     print('Document does not exist on the database');
    //   }
    // });

  }

  // Stream<List<User>> readUserData() => FirebaseFirestore.instance
  //     .collection('users')
  //     .snapshots()
  //     .map((snapshot) => snapshot.docs.map((doc) => User.fromJson(doc.data())).toList());

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
              // TODO implement uploading picture from firebase and finish implementations of editing picture on edit profile page
              CircleAvatar(radius: 30, backgroundImage: FirebaseImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(fontSize: 14, color: Colors.white),
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
    final color = Colors.white;
    final hoverColor = Colors.white70;

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
