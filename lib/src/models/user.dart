import 'package:themakerspace/src/constants.dart';

class User {
  final String url;
  final int id;
  final String username;
  final int userId;
  final String email;
  final String token;

  User(
      {required this.url,
      required this.id,
      required this.username,
      required this.userId,
      required this.email,
      required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        url: "${Constants.apiUrl}/rest/users/${json['id']}/",
        id: json["id"],
        username: json['username'],
        userId: json['user_id'],
        email: json['email'],
        token: json["token"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'username': username,
      'user_id': userId,
      'email': email,
      "token": token
    };
  }
}
