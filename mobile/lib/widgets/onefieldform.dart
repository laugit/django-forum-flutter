import 'package:flutter/material.dart';
import 'package:mobile/serializers/message.dart';
import 'package:mobile/serializers/topic.dart';
import 'package:mobile/serializers/user.dart';
import 'package:mobile/widgets/bigtextinput.dart';
import 'package:mobile/widgets/smalltextinput.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../screens/topicdetail.dart';

class OneFieldForm extends StatefulWidget {
  const OneFieldForm(
      {required this.fieldController,
      required this.bigInputText,
      required this.saveButtonText,
      super.key});

  final TextEditingController fieldController;
  final String bigInputText;
  final String saveButtonText;

  @override
  OneFieldFormState createState() {
    return OneFieldFormState();
  }
}

class OneFieldFormState extends State<OneFieldForm> {
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
              BigTextInput(
                  controller: widget.fieldController,
                  inputText: widget.bigInputText),
              const SizedBox(
                height: 15,
              ),
              Consumer<TopicAndCreatorModel>(
                  builder: (context, topicmodel, child) {
                return Center(
                    child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      createMessage(
                          topicmodel.currentpk, widget.fieldController.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      textStyle: const TextStyle(color: Colors.white)),
                  child: Text(widget.saveButtonText),
                ));
              })
            ],
          ),
        ));
  }
}
