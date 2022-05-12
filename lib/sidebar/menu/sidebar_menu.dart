import 'package:flutter/material.dart';
import 'package:services_catalog/sidebar/menu/head_item.dart';
import 'package:services_catalog/sidebar/menu/log_out_item.dart';
import 'package:services_catalog/sidebar/page/user_page/user_profil_page.dart';


class SideBarMenu extends StatelessWidget {

  final EdgeInsets padding;
  final Map<String, dynamic> data;
  final String? uid;

  const SideBarMenu({Key? key, required this.padding, required this.data, this.uid}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: const Color.fromRGBO(199, 230, 190, 90),
        child: ListView(
          children: <Widget>[

            HeadItem(padding: padding,
              urlImage: data['imagePath'],
              name: data['name'],
              email: data['email'],
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UserProfilePage(
                  imagePath: data['imagePath'],
                  data: data,
                  uid: uid!,
                ),
              )),
            ),

            LogOutItem(padding: padding)
          ],
        ),

      ),
    );
  }
}