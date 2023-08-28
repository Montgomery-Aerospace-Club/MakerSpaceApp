import 'dart:convert';
import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:themakerspace/src/constants.dart';
import 'package:themakerspace/src/models/component_list.dart';
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
  Map<String, String> requestBody = {
    "username": username,
    "password": password,
    "email": email,
    "user_id": userId,
  };
  final response = await http.post(
      Uri.parse("${Constants.apiUrl}/rest/users/register/"),
      body: requestBody);

  Map<String, dynamic> body = json.decode(response.body);
  Map<String, String> usernameError = {
    "Username": (body["username"] ?? [null])[0] ?? ""
  };
  Map<String, String> emailError = {
    "Email": (body["email"] ?? [null])[0] ?? ""
  };
  Map<String, String> userIdError = {
    "User ID": (body["user_id"] ?? [null])[0] ?? ""
  };
  Map<String, String> passwordError = {
    "Password": (body["password"] ?? [null])[0] ?? ""
  };

  List<Map<String, String>> errors = [
    usernameError,
    emailError,
    userIdError,
    passwordError
  ];

  String errorMsg = "";
  bool hadError = false;

  for (Map<String, String> error in errors) {
    for (String key in error.keys) {
      if (error[key]!.isNotEmpty) {
        errorMsg += "$key Error: ${error[key]}\n";
        hadError = true;
      }
    }
  }
  if (hadError) {
    errorMsg +=
        "Please fix the errors above in this form and the previous form";
  } else {
    await login(username, password);
  }

  return errorMsg;
}

Future<ComponentList> getComponents() async {
  String token = await readToken();

  if (token.isEmpty) {
    return ComponentList(components: [], suggestions: []);
  }

  Map<String, String> headers = {"Authorization": "Token $token"};

  try {
    final response = await http.get(
        Uri.parse("${Constants.apiUrl}/rest/components/"),
        headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Map<String, dynamic>> componentsJson =
          body.map((e) => ComponentList.convertToMapDynamic(e)).toList();

      ComponentList lst = ComponentList.fromJson(componentsJson);

      writeComponentList(lst);

      return lst;
    }
  } catch (error) {
    debugPrint(error.toString());
    return readComponentList();
  }

  return ComponentList(components: [], suggestions: []);
}

Future<ComponentList> searchComponents(String text) async {
  String token = await readToken();

  if (token.isEmpty) {
    return ComponentList(components: [], suggestions: []);
  }

  Map<String, String> headers = {"Authorization": "Token $token"};

  final response = await http.get(
      Uri.parse("${Constants.apiUrl}/rest/components/?search=$text/"),
      headers: headers);

  if (response.statusCode == 200) {
    List<dynamic> body = json.decode(response.body);
    List<Map<String, dynamic>> componentsJson =
        body.map((e) => ComponentList.convertToMapDynamic(e)).toList();

    ComponentList lst = ComponentList.fromJson(componentsJson);

    return lst;
  }

  return ComponentList(components: [], suggestions: []);
}
