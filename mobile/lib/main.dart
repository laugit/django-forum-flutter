import 'package:flutter/material.dart';
import 'package:mobile/screens/newtopic.dart';
import 'package:mobile/screens/newmessage.dart';
import 'package:mobile/screens/showprofile.dart';
import 'package:mobile/screens/editprofile.dart';
import 'package:mobile/screens/topicdetail.dart';
import 'package:mobile/screens/topiclist.dart';
import 'package:mobile/serializers/topic.dart';
import 'package:mobile/serializers/user.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TopicAndCreatorModel(),
      child: MaterialApp(
        title: 'Flutter Django forum by Laura', // used by the OS task switcher
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the TopicListScreen widget.
          '/': (context) => const TopicListScreen(),
          '/new': (context) => const NewTopicScreen(),
          '/new-message': (context) => const NewMessageScreen(),
          '/profile': (context) => const ShowProfileScreen(),
          '/profile-edit': (context) => const EditProfileScreen(),
          '/details': (context) => const TopicDetailScreen()
        },
      ),
    ),
  );
}

class TopicAndCreatorModel extends ChangeNotifier {
  int pk = 0;
  Future<User> user = fetchUser();

  /// The current clicked topic info
  Future<Topic> get topic => retrieveTopic(pk);
  int get currentpk => pk;
  Future<User> get currentuser => user;

  /// Change the topic pk
  void changePk(int newpk) {
    pk = newpk;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void changeUser() {
    user = fetchUser();
    notifyListeners();
  }
}
