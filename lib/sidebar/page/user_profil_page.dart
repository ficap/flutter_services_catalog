import 'package:flutter/material.dart';
import '../widget/appbar_widget.dart';
import '../widget/profile_widget.dart';
import 'editing_user_profile_page.dart';

class UserPage extends StatelessWidget {
  final String? imagePath;
  final Map<String, dynamic> data;
  final String uid;


  const UserPage({
    Key? key, this.imagePath, required this.data, required this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: imagePath!,
            onClicked: () {
              Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => EditProfilePage(data: data, imagePath: imagePath!, uid: uid!,)),);
              }, isEdit: true,
          ),
          const SizedBox(height: 24),
          // buildName(),
          Column(
            children: [
              Text(data['name'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 4),
              Text(
                data['email'],
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  data['about'],
                  style: TextStyle(fontSize: 16, height: 1.4),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}