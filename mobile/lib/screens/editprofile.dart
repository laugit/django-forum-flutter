import 'package:flutter/material.dart';
import 'package:mobile/widgets/twofieldsform.dart';
import 'package:mobile/widgets/usericon.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            leading: const BackButton(),
            title: const Text("Edit"),
            actions: const [UserIcon()]),
        body: TwoFieldsForm(
          titleController: TextEditingController(),
          descriptionController: TextEditingController(),
          smallInputText: "Nom",
          bigInputText: "Prénom",
          saveButtonText: "Save",
          isCreation: false,
        ));
  }
}
