import 'package:mobile/serializers/user.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Message> createMessage(topicpk, message) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:8000/api/topic/$topicpk/message/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'message': message}),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    print(response.body);
    return Message.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    print(response.body);
    throw Exception('Failed to create message');
  }
}

class Message {
  final String message;
  final User creator;
  final String createdAt;

  const Message(
      {required this.message, required this.creator, required this.createdAt});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        message: json["message"],
        creator: User.fromJson(json["creator_serializer"], false),
        createdAt: json["created_at"]);
  }
}
