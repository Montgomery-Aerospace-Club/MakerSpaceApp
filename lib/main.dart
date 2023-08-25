import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:themakerspace/src/app.dart';
import 'package:themakerspace/src/utils/http_overrides.dart';
import 'package:themakerspace/src/utils/theme.dart';
import 'package:window_size/window_size.dart';

/*
Platform.isAndroid
Platform.isFuchsia
Platform.isIOS
Platform.isLinux
Platform.isMacOS
Platform.isWindows

import 'package:flutter/foundation.dart' show kIsWeb;

if (kIsWeb) {
  // running on the web!
} else {
  // NOT running on the web! You can check for additional platforms here.
}

if (UniversalPlatform.isWindows ||
      UniversalPlatform.isLinux ||
      UniversalPlatform.isMacOS) {
    setWindowMinSize(const Size(300, 650));
    setWindowMaxSize(Size.infinite);
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
*/

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  List<ThemeData> themelist = await giveMeLightAndDark();
  ThemeData lightTheme = themelist[0];
  ThemeData darkTheme = themelist[1];

  if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
    setWindowMinSize(const Size(300, 650));
    setWindowMaxSize(Size.infinite);
  }

  runApp(MontyMakerSpaceApp(
    lightTheme: lightTheme,
    darkTheme: darkTheme,
  ));
}
