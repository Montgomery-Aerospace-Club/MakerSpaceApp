import 'dart:convert';
import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:themakerspace/src/constants.dart';
import 'package:themakerspace/src/models/borrow.dart';
import 'package:themakerspace/src/models/borrow_list.dart';
import 'package:themakerspace/src/models/component_list.dart';
import 'package:themakerspace/src/models/user.dart';
import 'package:themakerspace/src/providers/cookies.dart';
import 'package:themakerspace/src/providers/utils.dart';

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

Future<ComponentList> getOrSearchComponents(String query) async {
  String token = await readToken();

  if (token.isEmpty) {
    return ComponentList(components: [], suggestions: []);
  }

  Map<String, String> headers = {"Authorization": "Token $token"};

  try {
    final response = await http.get(
        Uri.parse("${Constants.apiUrl}/rest/components/?search=$query"),
        headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Map<String, dynamic>> componentsJson =
          body.map((e) => convertToMapDynamic(e)).toList();

      ComponentList lst = ComponentList.fromJson(componentsJson);

      if (query.isEmpty) {
        writeComponentList(lst);
      }

      return lst;
    }
  } catch (error) {
    debugPrint(error.toString());
    return readComponentList();
  }

  return ComponentList(components: [], suggestions: []);
}

Future<BorrowList> getOrSearchBorrows(
    String? query, bool? borrowInProgress) async {
  String token = await readToken();

  BorrowList ret = BorrowList(
      borrows: [],
      suggestions: [],
      components: ComponentList(components: [], suggestions: []));

  if (token.isEmpty) {
    return ret;
  }

  Map<String, String> headers = {"Authorization": "Token $token"};

  String borrowInProgQuery = "";
  if (borrowInProgress != null) {
    borrowInProgQuery = "${borrowInProgress ? 1 : 0}";
  }

  final uri =
      Uri.parse('${Constants.apiUrl}/rest/borrows/').replace(queryParameters: {
    "search": query ?? "",
    "borrow_in_progress": borrowInProgQuery,
  });
  try {
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Map<String, dynamic>> componentsJson =
          body.map((e) => convertToMapDynamic(e)).toList();

      BorrowList lst = BorrowList.fromJson(componentsJson);

      if (query == null) {
        writeBorrowList(lst);
      }

      return lst;
    }
  } catch (error) {
    debugPrint(error.toString());
    return readBorrowList();
  }

  return ret;
}

Future<List<Borrow>> getBorrowsWithFilterSet({
  String? componentID,
  bool? borrowInProgress,
}) async {
  List<Borrow> ret = [];

  String token = await readToken();

  if (token.isEmpty) {
    return ret;
  }
  Map<String, String> headers = {"Authorization": "Token $token"};

  String borrowInProgQuery = "";
  if (borrowInProgress != null) {
    borrowInProgQuery = "${borrowInProgress ? 1 : 0}";
  }

  final uri =
      Uri.parse('${Constants.apiUrl}/rest/borrows/').replace(queryParameters: {
    "borrow_in_progress": borrowInProgQuery,
    "component__id": componentID ?? "",
  });

  final response = await http.get(uri, headers: headers);

  if (response.statusCode == 200) {
    List<dynamic> body = json.decode(response.body);
    List<Map<String, dynamic>> componentsJson =
        body.map((e) => convertToMapDynamic(e)).toList();

    List<Map<String, dynamic>> borrowsJson =
        componentsJson.map((e) => convertToMapDynamic(e)).toList();

    for (Map<String, dynamic> borrowJson in borrowsJson) {
      if (borrowJson.isNotEmpty) {
        Borrow bor = Borrow.fromJson(borrowJson);
        ret.add(bor);
      }
    }
  }

  return ret;
}

void logout() {
  logoutClearCookies();
}
