import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
