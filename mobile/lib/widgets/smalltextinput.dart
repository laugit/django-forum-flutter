import 'package:flutter/material.dart';

class SmallTextInput extends StatelessWidget {
  const SmallTextInput(
      {required this.controller, required this.inputText, super.key});

  final TextEditingController controller;
  final String inputText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      decoration: InputDecoration(labelText: inputText),
      validator: (value) {
        if (value == null || value.isEmpty || value == "") {
          return 'Please enter some text';
        }
        return null;
      },
      controller: controller,
    );
  }
}
