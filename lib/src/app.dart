import 'package:flutter/material.dart';
import 'package:themakerspace/src/debug/debug_view.dart';
import 'package:themakerspace/src/screens/login.dart';
import 'package:themakerspace/src/screens/home.dart';

/// The Widget that configures your application.
class MontyMakerSpaceApp extends StatefulWidget {
  const MontyMakerSpaceApp(
      {super.key, required this.darkTheme, required this.lightTheme});

  final ThemeData darkTheme;
  final ThemeData lightTheme;

  @override
  State<MontyMakerSpaceApp> createState() => _MontyMakerSpaceAppState();
}

class _MontyMakerSpaceAppState extends State<MontyMakerSpaceApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "The Maker Space",
        theme: widget.lightTheme,
        darkTheme: widget.darkTheme,
        home: const Debug());
  }
}
