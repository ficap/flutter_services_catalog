import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:services_catalog/authentication/authentification.dart';
import 'package:services_catalog/entities/provider_model.dart';
import 'package:services_catalog/sidebar/menu/head_item.dart';
import 'package:services_catalog/sidebar/menu/log_out_item.dart';
import 'package:services_catalog/sidebar/page/user_page/user_profil_page.dart';


class SideBarMenu extends StatelessWidget {

  final EdgeInsets padding;
  final ProviderModel? providerModel;

  const SideBarMenu({Key? key, required this.padding, this.providerModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("rebuild sidebar");
    final Widget then = providerModel != null
        ? const UserProfilePage()
        : const AuthenticationScreen();

    return Drawer(
      child: Material(
        color: const Color.fromRGBO(199, 230, 190, 90),
        child: ListView(
          children: <Widget>[
            HeadItem(
              padding: padding,
              urlImage: providerModel?.imagePath ?? "gs://" + FirebaseStorage.instance.ref().bucket + "/image_for_service_app/profile_image.png",
              name: providerModel?.name ?? "Sign In",
              email: providerModel?.email ?? "",
              onClicked: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return then;
                  },
                ),
              ),
            ),
            if(providerModel != null)
              LogOutItem(padding: padding)
          ],
        ),
      ),
    );
  }
}