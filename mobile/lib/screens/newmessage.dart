import 'package:flutter/material.dart';
import 'package:mobile/widgets/onefieldform.dart';
import 'package:mobile/widgets/usericon.dart';

class NewMessageScreen extends StatelessWidget {
  const NewMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            leading: const BackButton(),
            title: const Text("New message"),
            actions: const [UserIcon()]),
        body: OneFieldForm(
          fieldController: TextEditingController(),
          bigInputText: "Message",
          saveButtonText: "Post a message",
        ));
  }
}
