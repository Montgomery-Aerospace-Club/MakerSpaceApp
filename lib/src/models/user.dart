import 'package:themakerspace/src/constants.dart';

class User {
  final String url;
  final int id;
  final String username;
  final int userId;
  final String email;
  final String? token;
  final bool isAdmin;

  User(
      {required this.url,
      required this.id,
      required this.username,
      required this.userId,
      required this.email,
      this.token = "",
      this.isAdmin = false});

  factory User.fromJson(Map<String, dynamic> json) {
    String url = "";
    if (json["id"] == null) {
      url = json["url"];
      json["id"] =
          int.tryParse(url.split("/users/")[1].replaceAll("/", "")) ?? 0;
    } else {
      url = "${Constants.apiUrl}/rest/users/${json['id']}/";
    }

    return User(
        url: url,
        id: json["id"],
        username: json['username'],
        userId: json['user_id'],
        email: json['email'],
        token: json["token"],
        isAdmin: json["isadmin"] ?? false);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'username': username,
      'user_id': userId,
      'email': email,
      "token": token,
      "isadmin": isAdmin
    };
  }

  @override
  String toString() {
    return "\n[DEBUG (student toString())]\n---------\nID: $id ${id.runtimeType}\nUsername: $username ${username.runtimeType}\nemail: $email\nUser_id: $userId ${userId.runtimeType}\n------------";
  }
}
