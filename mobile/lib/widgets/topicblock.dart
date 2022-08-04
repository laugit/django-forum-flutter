import 'package:flutter/material.dart';

class TopicBlock extends StatelessWidget {
  const TopicBlock(
      {required this.headingText,
      required this.title,
      required this.trailingText,
      required this.avatarUrl,
      super.key});

  final Text headingText;
  final String title;
  final String trailingText;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(top: 10),
        elevation: 2,
        child: Column(children: [
          Container(
              padding: const EdgeInsets.only(top: 5, left: 15),
              alignment: Alignment.topLeft,
              child: headingText),
          ListTile(
            leading: SizedBox(
                width: 110,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                          radius: 12, backgroundImage: NetworkImage(avatarUrl)),
                      Text(
                        title,
                        textAlign: TextAlign.left,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ])),
            title: const SizedBox(
              width: 0,
            ),
            trailing: Text(
              trailingText,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ]));
  }
}
