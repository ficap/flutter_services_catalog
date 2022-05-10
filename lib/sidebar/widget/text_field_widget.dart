import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const TextFieldWidget({Key? key, required this.controller, required this.onChanged}) : super(key: key);


  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        controller.text,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      const SizedBox(height: 8),
      TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onChanged:onChanged,
      ),
    ],
  );
}