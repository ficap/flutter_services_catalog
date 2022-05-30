import 'package:file_picker/file_picker.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:provider/provider.dart';
import 'package:services_catalog/authentication/add_user_page.dart';
import 'package:services_catalog/di.dart';
import 'package:services_catalog/entities/provider_model.dart';
import 'package:services_catalog/fire_base/storage.dart';
import 'package:services_catalog/my_color.dart';


class CarouselSliderWidget extends StatelessWidget {
  final String uid;
  static int imageCount = 0;
  final Storage storage = Storage();
  final bool addingEnabled;
  CarouselSliderWidget({Key? key, required this.uid, this.addingEnabled = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<ProviderModel?>(
          stream: Provider.of<DI>(context).currentUserStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return Container();
            }
            final providerModel = snapshot.data!;
            // return Container();

            if(providerModel.pictureUrls != "empty") {

              final urlList = providerModel.pictureUrls.split(";");
              print("AAAAAAAAAAAAAAAAAAAA");
              print(urlList);

              return Container(
                child: Column(
                  children: [
                    CarouselSlider.builder(
                      options: CarouselOptions(
                        height: 400,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        // onPageChanged: ,
                        scrollDirection: Axis.horizontal,
                      ),
                      itemCount: urlList.length,
                      itemBuilder: (context, int itemIndex, int pageViewIndex) {
                        return Image(
                          image: FirebaseImage(urlList[itemIndex]),
                        );
                      },
                    ),
                    addButton(providerModel: providerModel),
                  ],
                ),

              );
            }

            return addButton(providerModel: providerModel);
          })
      ],
    );
  }

  Widget addButton({
    required ProviderModel providerModel,
  }) =>
      Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: MyColor.buttonColor,
          ),
          child: MaterialButton(
            onPressed: () async {
              print(FirebaseStorage.instance.ref().bucket);
              final destination = 'files/' + uid + "/picture_gallery";
              final results = await FilePicker.platform.pickFiles(
                allowMultiple: false,
                type: FileType.custom,
                allowedExtensions: ['png', 'jpg'],
              );
              if (results == null) {
                // ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('No file selected'),
                  // ),
                );
                return;
              }
              final path = results.files.single.path!;
              final fileName = results.files.single.name;
              if (providerModel.pictureUrls == "empty") {
                providerModel.pictureUrls = "gs://second-db-fluter.appspot.com/" + destination + "/" + fileName;
              }
              else if (!providerModel.pictureUrls.contains("gs://second-db-fluter.appspot.com/" + destination + "/" + fileName)){
                providerModel.pictureUrls +=
                    ";" + "gs://second-db-fluter.appspot.com/" + destination + "/" + fileName;
              }
              print(providerModel.pictureUrls);

              final user = ProviderModel(
                  serviceType: providerModel.serviceType,
                  name: providerModel.name,
                  about: providerModel.about,
                  imagePath: providerModel.imagePath,
                  pictureUrls: providerModel.pictureUrls
              );
              AddUserPage.createUser(user);

              storage
                  .uploadFile(path, destination, fileName)
                  .then((value) => print('Done'));
              // Navigator.pop(context);
            },
            child: Text('Add new photo'),
          )
      );
}