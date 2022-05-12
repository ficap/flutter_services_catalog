import 'package:flutter/material.dart';
import 'package:services_catalog/sidebar/widget/carousel/carousel_slider.dart';
import 'package:services_catalog/sidebar/widget/user_widget/profile_widget.dart';
import 'editing_user_profile_page.dart';

class UserProfilePage extends StatelessWidget {
  final String? imagePath;
  final Map<String, dynamic> data;
  final String uid;
  final Color textColor = const Color.fromRGBO(93, 107, 89, 42);
  final Color userBackgroundColor = Colors.white;


  const UserProfilePage({
    Key? key, this.imagePath, required this.data, required this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: userBackgroundColor,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: textColor,
      ),

      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: imagePath!,
            onClicked: () {
              Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => EditProfilePage(data: data, imagePath: imagePath!, uid: uid,)),);
              }, isEdit: true,
          ),
          const SizedBox(height: 24),

          Column(
            children: [
              Text(data['name'],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 4),

              Text(
                data['email'],
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 30),

              Text(
                data['about'],
                style: const TextStyle(fontSize: 16, height: 1.4),
              ),
              const SizedBox(height: 24),
            ],
          ),

          CarouselSliderWidget(uid: uid),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}