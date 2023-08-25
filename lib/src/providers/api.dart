import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:themakerspace/src/constants.dart';
import 'package:themakerspace/src/models/user.dart';
import 'package:themakerspace/src/providers/cookies.dart';

Future<bool> login(String username, String password) async {
  Map<String, String> requestBody = {
    "username": username,
    "password": password
  };

  final response = await http.post(
      Uri.parse("${Constants.apiUrl}/api-user-login/"),
      body: requestBody);

  Map<String, dynamic> body = json.decode(response.body);

  if (response.statusCode == 200) {
    // good to go
    String token = body["token"] ?? "";
    if (token.isEmpty) {
      return false;
    }
    writeUser(User.fromJson(body));
    writeToken(token);
    return true;
  } else {
    return false;
  }
}

Future<String> register(
    String username, String password, String email, String userId) async {
  Map<String, dynamic> requestBody = {
    "username": username,
    "password": password,
    "email": email,
    "user_id": int.parse(userId),
  };
  print(requestBody);
  // final response = await http.post(
  //     Uri.parse("${Constants.apiUrl}/rest/users/register/"),
  //     body: requestBody);

  // Map<String, dynamic> body = json.decode(response.body);
  // print(body);

  return "";
}
