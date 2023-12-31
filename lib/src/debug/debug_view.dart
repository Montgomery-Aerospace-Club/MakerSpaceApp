import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:themakerspace/src/models/component_list.dart';
import 'package:themakerspace/src/models/user.dart';
import 'package:themakerspace/src/providers/api.dart';
import 'package:themakerspace/src/providers/cookies.dart';
import 'package:themakerspace/src/widgets/appbar.dart';
import 'package:themakerspace/src/widgets/debug_button.dart';
import 'package:themakerspace/src/widgets/navbar.dart';

class Debug extends StatefulWidget {
  const Debug({super.key});

  @override
  State<Debug> createState() => _DebugState();
}

class _DebugState extends State<Debug> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generateAppbar(title: "Debug", elevate: true),
      bottomNavigationBar: const Navbar(
        selectedIndex: 1,
      ),
      body: SafeArea(
          child: Center(
              child: Column(
        children: [
          giveMeDebugButton("login", () async {
            String valid = await login("eddie", "admin123", false);
            if (valid.isNotEmpty) {
              User student = await readUser();

              debugPrint(student.toString());
            }
          }),
          giveMeDebugButton("components", () async {
            ComponentList components = await getOrSearchComponents("");

            if (components.isEmpty) {
              debugPrint(
                  "Token invalid? Or return invalid? Or just no components?");
            } else {
              ComponentList lst = await readComponentList();
              debugPrint(json.encode(lst.toJson()));
            }
          }),
        ],
      ))),
    );
  }
}
