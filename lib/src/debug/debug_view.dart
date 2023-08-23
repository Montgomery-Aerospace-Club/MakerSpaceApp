import 'package:flutter/material.dart';
import 'package:monty_makerspace/src/widgets/appbar.dart';
import 'package:monty_makerspace/src/widgets/navbar.dart';

class Debug extends StatefulWidget {
  const Debug({super.key});

  @override
  State<Debug> createState() => _DebugState();
}

class _DebugState extends State<Debug> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generateAppbar(),
      bottomNavigationBar: const Navbar(
        selectedIndex: 0,
      ),
      body: SafeArea(
          child: Column(
        children: [
          ListView.builder(itemBuilder: (context, i) {
            return const ListTile();
          })
        ],
      )),
    );
  }
}
