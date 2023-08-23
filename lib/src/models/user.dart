class User {
  final int id; // You can use a unique identifier for each user
  final String name;
  final int userId;
  final String email;

  User({
    required this.id,
    required this.name,
    required this.userId,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      userId: json['userId'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'userId': userId,
      'email': email,
    };
  }
}
