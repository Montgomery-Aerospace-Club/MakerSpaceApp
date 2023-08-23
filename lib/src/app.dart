import 'package:flutter/material.dart';
import 'package:monty_makerspace/src/debug/debug_view.dart';

/// The Widget that configures your application.
class MontyMakerSpaceApp extends StatelessWidget {
  const MontyMakerSpaceApp(
      {super.key, required ThemeData lightTheme, required ThemeData darkTheme});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "The Maker Space",
        theme: ThemeData(),
        darkTheme: ThemeData.dark(),
        home: const Debug());
  }
}
