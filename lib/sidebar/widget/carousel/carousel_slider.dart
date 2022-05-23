import 'package:file_picker/file_picker.dart';
import 'package:firebase_image/firebase_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:services_catalog/fire_base/storage.dart';


class CarouselSliderWidget extends StatelessWidget {
  final String uid;
  static int imageCount = 0;
  final Storage storage = Storage();
  final Color textColor = Color.fromRGBO(93, 107, 89, 42);
  final Color backgroundColor = Color.fromRGBO(199, 230, 190, 90);
  final Color buttonColor = Color.fromRGBO(77, 82, 76, 32);
  final bool addingEnabled;
  CarouselSliderWidget({Key? key, required this.uid, this.addingEnabled = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: storage.listFile(uid),
          builder: (context,
              AsyncSnapshot<firebase_storage.ListResult> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              var length = snapshot.data?.items.length;
              if (length! >= 1) {
                return Container(
                  child: CarouselSlider.builder(
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
                    itemCount: snapshot.data?.items.length,
                    itemBuilder: (context, int itemIndex, int pageViewIndex) {
                      return Image(
                        image: FirebaseImage("gs://" +
                            FirebaseStorage.instance.ref().bucket + "/files/" + uid +
                                "/picture_gallery/" + snapshot.data!
                                .items[itemIndex].name),
                      );
                    },

                  ),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting ||
                !snapshot.hasData) {
              return CircularProgressIndicator();
            }
            return Container();
          }
        ),

        if (addingEnabled)
          Container(
          // width: 300,
          height: 50,
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: buttonColor,
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('No file selected'),
                      ),
                    );
                    return;
                  }
                  final path = results.files.single.path!;
                  final fileName = results.files.single.name;

                  storage
                      .uploadFile(path, destination, fileName)
                      .then((value) => print('Done'));

                  Navigator.pop(context);
                },
                child: Text('Add new photo'),
              )
          )
      ],
    );
  }
}