import 'dart:io';

import 'package:flutter/material.dart';
import 'package:monty_makerspace/src/app.dart';
import 'package:monty_makerspace/src/utils/http_overrides.dart';
import 'package:monty_makerspace/src/utils/theme.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  List<ThemeData> themelist = await giveMeLightAndDark();
  ThemeData lightTheme = themelist[0];
  ThemeData darkTheme = themelist[1];

  runApp(MontyMakerSpaceApp(
    lightTheme: lightTheme,
    darkTheme: darkTheme,
  ));
}
