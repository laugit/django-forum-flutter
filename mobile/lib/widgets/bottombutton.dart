import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  const BottomButton(
      {required this.buttonIcon, required this.onPushRoute, super.key});

  final IconData buttonIcon;
  final String onPushRoute;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, onPushRoute);
        },
        child: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue,
          child: Icon(
            buttonIcon,
            color: Colors.white,
            size: 25,
          ),
        ));
  }
}
