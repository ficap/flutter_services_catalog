import 'package:flutter/material.dart';

class AddUserFieldController extends StatelessWidget {

  final TextEditingController controller;
  final Color textColor;
  final String hintText;
  final String lableText;

  const AddUserFieldController({Key? key, required this.controller, required this.textColor, required this.hintText, required this.lableText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: TextFormField(
        style: TextStyle(color: textColor),
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: textColor,
          ),
          labelText: lableText,
          labelStyle: TextStyle(
            color: textColor,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: textColor),
          ),
        ),
      ),
    );
  }

}