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
        selectedIndex: 1,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, i) {
                    return const ListTile();
                  }))
        ],
      )),
    );
  }
}
