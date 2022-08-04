import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../serializers/user.dart';

class UserIcon extends StatelessWidget {
  const UserIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () {
      Navigator.pushNamed(context, '/profile');
    }, child:
        Consumer<TopicAndCreatorModel>(builder: (context, creatormodel, child) {
      return FutureBuilder<User>(
          future: creatormodel.currentuser,
          builder: (context, user) {
            if (user.hasData) {
              return CircleAvatar(
                backgroundImage:
                    NetworkImage("http://10.0.2.2:8000${user.data!.avatarUrl}"),
              );
            }
            return const CircularProgressIndicator();
          });
    }));
  }
}
