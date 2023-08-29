import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themakerspace/src/debug/debug_view.dart';
import 'package:themakerspace/src/models/borrow_list.dart';
import 'package:themakerspace/src/models/component_list.dart';
import 'package:themakerspace/src/providers/cookies.dart';
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
  bool? tokenExists;

  @override
  void initState() {
    readToken().then((value) {
      setState(() {
        tokenExists = value.isNotEmpty;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ComponentList>(
          create: (context) {
            return ComponentList(components: [], suggestions: []);
          },
          lazy: false,
        ),
        ChangeNotifierProvider<BorrowList>(
          create: (context) {
            return BorrowList(
                borrows: [],
                suggestions: [],
                components: ComponentList(components: [], suggestions: []));
          },
          lazy: false,
        )
      ],
      builder: (context, child) {
        //while (tokenExists == null) {}
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "The Maker Space",
            theme: widget.lightTheme,
            darkTheme: widget.darkTheme,
            home: tokenExists ?? false ? const Home() : const Login());
      },
    );
  }
}
