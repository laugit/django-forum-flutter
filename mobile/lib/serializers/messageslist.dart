import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/serializers/topic.dart';
import 'package:mobile/serializers/message.dart';

class MessagesList {
  final List<Message> results;

  const MessagesList({required this.results});

  factory MessagesList.fromJson(List<dynamic> json) {
    List<Message> messageslist = [];
    if (json.isNotEmpty) {
      int messageslen = json.length;
      for (int i = 0; i < messageslen; i++) {
        messageslist.add(Message.fromJson(json[i]));
      }
    }
    return MessagesList(
      results: messageslist,
    );
  }
}
