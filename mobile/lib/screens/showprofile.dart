import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inspector/inspector.dart';
import 'package:mobile/serializers/user.dart';
import 'package:mobile/widgets/bottombutton.dart';
import 'package:mobile/widgets/usertopics.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../serializers/topicslist.dart';

class ShowProfileScreen extends StatelessWidget {
  const ShowProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Inspector(
        child: Scaffold(
            appBar: AppBar(
              leading: const BackButton(),
            ),
            floatingActionButton: const BottomButton(
              buttonIcon: Icons.draw,
              onPushRoute: "/profile-edit",
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            body: ListView(
              children: [
                FutureBuilder<User>(
                  future: fetchUser(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        padding: const EdgeInsets.only(top: 20),
                        width: 375,
                        child: Column(
                          children: [
                            InkWell(
                                splashColor: Colors.grey,
                                radius: 50,
                                onTap: () {
                                  _updateAvatarFromGallery(
                                      context,
                                      snapshot.data?.firstName,
                                      snapshot.data?.lastName);
                                },
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                      "http://10.0.2.2:8000${snapshot.data?.avatarUrl}"),
                                )),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${snapshot.data?.fullname}",
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                                "Joined about ${DateTime.now().difference(DateTime.parse("${snapshot.data?.datejoined}")).inDays ~/ 365} days ago"),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text("Topics",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600))
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text(
                        "${snapshot.error}",
                        style: const TextStyle(color: Colors.red),
                      );
                    }
                    return const CircularProgressIndicator();
                  },
                ),
                const UserTopics()
              ],
            )));
  }

  _updateAvatarFromGallery(
      BuildContext context, String? firstName, String? lastName) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      String imageUrl = pickedFile.path;
      updateUser("$firstName", "$lastName", imageUrl);
      Timer(
          const Duration(seconds: 1),
          () => Provider.of<TopicAndCreatorModel>(context, listen: false)
              .changeUser());
    }
  }
}
