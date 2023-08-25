import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:themakerspace/src/constants.dart';
import 'package:themakerspace/src/models/user.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

Future<String> readToken() async {
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  String value = await storage.read(key: "token") ?? "";
  return value;
}

void writeToken(String token) async {
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  await storage.write(key: "token", value: token);
}

Future<User> readUser() async {
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  String value =
      await storage.read(key: "user") ?? json.encode(Constants.fakeUser);
  Map<String, dynamic> jsonn = json.decode(value);
  return User.fromJson(jsonn);
}

void writeUser(User user) async {
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  String stringJson = jsonEncode(user);
  await storage.write(key: "user", value: stringJson);
}


/*


  static Future<void> storeStudent(Student student) async {
    const storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
    String stringJson = jsonEncode(student.toJson());
    await storage.write(key: "student", value: stringJson);
  }

  static Future<Student> readStudent() async {
    const storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ));
    String jsonString = await storage.read(key: "student") ?? "";
    if (jsonString.isNotEmpty) {
      if (kDebugMode) {
        if (Constants.debugModePrintEVERYTHING) {
          print("[DEBUG: readStudent()->objects.dart]: $jsonString");
        }
      }
      Map<String, dynamic> jsonn = json.decode(jsonString);
      return Student.fromJson(jsonn);
    } else {
      return eddie;
    }
  }

  */