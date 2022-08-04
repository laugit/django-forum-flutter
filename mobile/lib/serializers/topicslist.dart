import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/serializers/topic.dart';

Future<TopicsList> fetchTopics() async {
  const String url = "http://10.0.2.2:8000/api/topic/";
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    return TopicsList.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print(response.body);
    throw Exception('Failed to load user');
  }
}

Future<TopicsList> fetchTopicsOfUser() async {
  const String url = "http://10.0.2.2:8000/api/topic/?user=1";
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    return TopicsList.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print(response.body);
    throw Exception('Failed to load user');
  }
}

class TopicsList {
  final int count;
  final List<Topic> results;

  const TopicsList({required this.count, required this.results});

  factory TopicsList.fromJson(Map<String, dynamic> json) {
    List<Topic> topiclist = [];
    if (json.containsKey("results") && json['results'].length > 0) {
      for (Map<String, dynamic> topic in json['results']) {
        topiclist.add(Topic.fromJson(topic));
      }
    }
    return TopicsList(
      count: json['count'] as int,
      results: topiclist,
    );
  }
}
