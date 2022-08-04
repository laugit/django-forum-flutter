import 'package:flutter/material.dart';

class BigTextInput extends StatelessWidget {
  const BigTextInput(
      {required this.controller, required this.inputText, super.key});

  final TextEditingController controller;
  final String inputText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLines: 4,
        decoration: InputDecoration(labelText: inputText),
        validator: (value) {
          if (value == null || value.isEmpty || value == "") {
            return 'Please enter some text';
          }
          return null;
        },
        controller: controller);
  }
}
