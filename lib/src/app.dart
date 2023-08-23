import 'package:flutter/material.dart';

/// The Widget that configures your application.
class MontyMakerSpaceApp extends StatelessWidget {
  const MontyMakerSpaceApp(
      {super.key, required ThemeData lightTheme, required ThemeData darkTheme});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
    );
  }
}
