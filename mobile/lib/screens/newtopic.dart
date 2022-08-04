import 'package:flutter/material.dart';
import 'package:mobile/widgets/twofieldsform.dart';
import 'package:mobile/widgets/usericon.dart';

class NewTopicScreen extends StatelessWidget {
  const NewTopicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            leading: const BackButton(),
            title: const Text("New topic"),
            actions: const [UserIcon()]),
        body: TwoFieldsForm(
          titleController: TextEditingController(),
          descriptionController: TextEditingController(),
          smallInputText: "Title",
          bigInputText: "Description",
          saveButtonText: "Create topic",
          isCreation: true,
        ));
  }
}
