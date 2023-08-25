import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:themakerspace/src/constants.dart';
import 'package:themakerspace/src/providers/cookies.dart';

// String username = "EDED2314";

/*

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('username', username);

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String action = prefs.getString('username') ?? "user123";
  return action;

*/

// returns True if the user is an admin. If admin, stores the crstf-token into shared preferences.
// Then we just add this token (if its valid it will work) to each header of each request (if it doesn't work it doesn't work)
// password would normally be user_id
// username would normally be username, but for admin, it is a username (again- to add variance)
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
    writeToken(token);
    return true;
  } else {
    return false;
  }
}
