import 'package:firebase_image/firebase_image.dart';
import 'package:flutter/material.dart';

class HeadItem extends StatelessWidget {
  final String urlImage;
  final String name;
  final String email;
  final VoidCallback onClicked;
  final EdgeInsets padding;

  const HeadItem({Key? key, required this.urlImage, required this.name, required this.email, required this.onClicked, required this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClicked,
      child: Container(
        padding: padding.add(const EdgeInsets.symmetric(vertical: 40)),
        child: Row(
          children: [
            CircleAvatar(radius: 30, backgroundImage: FirebaseImage(urlImage)),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 20, color: Color.fromRGBO(93, 107, 89, 42)),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: const TextStyle(fontSize: 14, color: Color.fromRGBO(93, 107, 89, 42)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}