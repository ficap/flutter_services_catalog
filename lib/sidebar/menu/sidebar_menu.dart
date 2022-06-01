import 'package:firebase_image/firebase_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:services_catalog/authentication/authentification.dart';
import 'package:services_catalog/di.dart';
import 'package:services_catalog/entities/provider_model.dart';
import 'package:services_catalog/sidebar/menu/log_out_item.dart';
import 'package:services_catalog/sidebar/page/user_page/editing_user_profile_page.dart';
import 'package:services_catalog/sidebar/page/user_page/user_profil_page.dart';
import 'package:services_catalog/sign_in.dart';


class SideBarMenu extends StatelessWidget {

  final EdgeInsets padding;
  final ProviderModel? providerModel;

  const SideBarMenu({Key? key, required this.padding, this.providerModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("rebuild sidebar");

    final String urlName = providerModel?.imagePath ?? "gs://" + FirebaseStorage.instance.ref().bucket + "/image_for_service_app/profile_image.png";

    return Drawer(

      child: Scaffold(
          body: StreamBuilder<ProviderModel?>(
              stream: Provider.of<DI>(context).currentUserStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return SignIn(padding: padding);
                }
                final providerModel = snapshot.data!;

                return ListView(
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          padding: padding,
                          child: InkWell(
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: FirebaseImage(urlName),
                            ),
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditProfilePage(
                                  data: providerModel,
                                  imagePath: providerModel.imagePath,
                                ),
                              ),
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => UserProfilePage(
                                // providerModel: providerModel,
                              ),
                            ),
                          ),
                          child: Container(
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      providerModel?.name ?? "Sign In",
                                      style: const TextStyle(fontSize: 20, color: Color.fromRGBO(93, 107, 89, 42)),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      providerModel?.email ?? "",
                                      style: const TextStyle(fontSize: 14, color: Color.fromRGBO(93, 107, 89, 42)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    if(providerModel != null)
                      LogOutItem(padding: padding)
                  ],
                );
              })
      ),
    );
  }
}