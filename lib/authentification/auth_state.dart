import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:services_catalog/authentification/ui/home_page.dart';
import 'package:services_catalog/user/my_user.dart';

import 'ui/authentification.dart';

class AuthState extends StatelessWidget {
  final user = FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// check if user is signed (Open Chat page ) if user is not signed in (open welcome page)
      initialRoute:
      FirebaseAuth.instance.currentUser == null ? Authentication.id : HomePage.id,

      ///key value pair
      routes: {
        HomePage.id: (context) => HomePage(),
        Authentication.id: (context) => Authentication(),
      },
      // home: Welcome(),
    );
  }

}