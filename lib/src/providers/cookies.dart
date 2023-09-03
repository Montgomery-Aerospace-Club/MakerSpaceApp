import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:themakerspace/src/constants.dart';
import 'package:themakerspace/src/models/borrow.dart';
import 'package:themakerspace/src/models/borrow_list.dart';
import 'package:themakerspace/src/models/component_list.dart';
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

Future<ComponentList> readComponentList() async {
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  String value = await storage.read(key: "components") ?? "[]";
  List<dynamic> jsonn = json.decode(value);
  return ComponentList.fromJson(jsonn);
}

void writeComponentList(ComponentList lst) async {
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  String stringJson = jsonEncode(lst);
  await storage.write(key: "components", value: stringJson);
}

Future<BorrowList> readBorrowList() async {
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  String value = await storage.read(key: "borrows") ?? "[]";
  List<dynamic> jsonn = json.decode(value);
  return BorrowList.fromJson(jsonn);
}

void writeBorrowList(BorrowList lst) async {
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  String stringJson = jsonEncode(lst);
  await storage.write(key: "borrows", value: stringJson);
}

Future<Borrow> readSearchBarBorrow() async {
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  String value = await storage.read(key: "searchBarBorrowSelection") ??
      json.encode(Constants.fakeBorrow);
  Map<String, dynamic> jsonn = json.decode(value);
  return Borrow.fromJson(jsonn);
}

Future<void> writeSelectedBorrow(Borrow bor) async {
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  String stringJson = jsonEncode(bor);
  await storage.write(key: "searchBarBorrowSelection", value: stringJson);
}

Future<void> resetSelectedBorrow() async {
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  await storage.delete(key: "searchBarBorrowSelection");
}

void logoutClearCookies() {
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
  storage.deleteAll();
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