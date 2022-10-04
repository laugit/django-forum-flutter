import 'dart:async';
import 'package:async/async.dart';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';

Future<User> fetchUser() async {
  const String url = "http://10.0.2.2:8000/api/user/";
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    print(response.body);
    return User.fromJson(jsonDecode(response.body)["results"][0], false);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print(response.body);
    throw Exception('Failed to load user');
  }
}

void updateUser(String firstName, String lastName, String avatarUrl) async {
  dynamic response;
  var url = Uri.parse('http://10.0.2.2:8000/api/user/1/update/');
  if (avatarUrl == "") {
    response = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'first_name': firstName,
          'last_name': lastName,
        }));
  } else {
    var image = File(avatarUrl);
    var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
    var length = await image.length();
    var request = http.MultipartRequest("PUT", url);
    var multiPartFile = http.MultipartFile('avatar', stream, length,
        filename: basename(avatarUrl));
    request.fields['first_name'] = firstName;
    request.fields['last_name'] = lastName;
    request.files.add(multiPartFile);
    response = await request.send();
  }

  if (response.statusCode == 200) {
    // If the server did return a 200 response,
    // then parse the JSON.
    if (avatarUrl == "") {
      print(response.body);
    } else {
      http.Response.fromStream(response).then((res) {
        print(res.body);
      });
    }
  } else {
    // If the server did not return a 200 response,
    // then throw an exception.
    if (avatarUrl == "") {
      print(response.body);
    } else {
      http.Response.fromStream(response).then((res) {
        print(res.body);
      });
    }
    throw Exception('Failed to update user.');
  }
}

class User {
  final String? email;
  final String? avatarUrl;
  final String firstName;
  final String lastName;
  final String? fullname;
  final String? datejoined;

  const User(
      {required this.email,
      required this.avatarUrl,
      required this.firstName,
      required this.lastName,
      required this.fullname,
      required this.datejoined});

  // Bonne pratique get fullUrl => url + avatarUrl
  factory User.fromJson(Map<String, dynamic> json, bool update) {
    return User(
      email: json['email'],
      avatarUrl: !update ? json['avatar_url'] : json['avatar'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      fullname: json['fullname'],
      datejoined: json['date_joined'],
    );
  }
}
