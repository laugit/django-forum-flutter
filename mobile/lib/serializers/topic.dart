import 'package:mobile/serializers/user.dart';
import 'package:mobile/serializers/message.dart';
import 'package:mobile/serializers/messageslist.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Topic> createTopic(String title, String description) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:8000/api/topic-create/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
      'description': description,
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);
    return Topic.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    print(response.body);
    throw Exception('Failed to create topic.');
  }
}

Future<Topic> retrieveTopic(int pk) async {
  final response =
      await http.get(Uri.parse("http://10.0.2.2:8000/api/topic/$pk/"));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    return Topic.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print(response.body);
    throw Exception('Failed to load topic.');
  }
}

class Topic {
  final int id;
  final String title;
  final String description;
  final User creator;
  final String createdAt;
  final int messagesCount;
  final MessagesList? messagesList;

  const Topic(
      {required this.id,
      required this.title,
      required this.description,
      required this.creator,
      required this.createdAt,
      required this.messagesCount,
      required this.messagesList});

  factory Topic.fromJson(Map<String, dynamic> json) {
    if (json.containsKey("messages_serializer")) {
      print("messages list");
      print(json['messages_serializer']);
    }
    return Topic(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        creator: User.fromJson(json['creator_serializer'], false),
        createdAt: json['created_at'],
        messagesCount: json['topicmessage_count'] as int,
        messagesList: MessagesList.fromJson(
            json.containsKey('messages_serializer') &&
                    json['messages_serializer'].length > 0
                ? json['messages_serializer']
                : []));
  }
}
