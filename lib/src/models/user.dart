class User {
  final String url;
  final String name;
  final int userId;
  final String email;

  User({
    this.url = "",
    required this.name,
    required this.userId,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      url: json['url'],
      name: json['name'],
      userId: json['user_id'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'name': name,
      'user_id': userId,
      'email': email,
    };
  }
}
