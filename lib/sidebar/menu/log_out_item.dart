import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:services_catalog/authentication/page/home_page.dart';
import 'package:services_catalog/sidebar/menu/menu_item.dart';

class LogOutItem extends StatelessWidget {

  final EdgeInsets padding;

  const LogOutItem({Key? key, required this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
        children: [
          const SizedBox(height: 12),

          MenuItem(
              text: 'Logout',
              icon: Icons.logout,
              onClicked: () => {
                FirebaseAuth.instance.signOut(),
                // Navigator.pushReplacement(
                //     context, MaterialPageRoute(
                //     builder: (context) => const HomePage()
                // ))
              }
          )
        ],
      ),
    );
  }

}