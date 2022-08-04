import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/serializers/topic.dart';
import 'package:mobile/serializers/user.dart';
import 'package:mobile/widgets/bigtextinput.dart';
import 'package:mobile/widgets/smalltextinput.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class TwoFieldsForm extends StatefulWidget {
  const TwoFieldsForm(
      {required this.titleController,
      required this.descriptionController,
      required this.smallInputText,
      required this.bigInputText,
      required this.saveButtonText,
      required this.isCreation,
      super.key});

  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final String smallInputText;
  final String bigInputText;
  final String saveButtonText;
  final bool isCreation;

  @override
  TwoFieldsFormState createState() {
    return TwoFieldsFormState();
  }
}

class TwoFieldsFormState extends State<TwoFieldsForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 700,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmallTextInput(
                  controller: widget.titleController,
                  inputText: widget.smallInputText),
              const SizedBox(
                height: 50,
              ),
              BigTextInput(
                  controller: widget.descriptionController,
                  inputText: widget.bigInputText),
              const SizedBox(
                height: 15,
              ),
              Center(
                  child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (widget.isCreation) {
                      createTopic(widget.titleController.text,
                          widget.descriptionController.text);
                    } else {
                      updateUser(widget.titleController.text,
                          widget.descriptionController.text, "");
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    textStyle: const TextStyle(color: Colors.white)),
                child: Text(widget.saveButtonText),
              ))
            ],
          ),
        ));
  }
}
