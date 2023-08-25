import 'package:flutter/material.dart';
import 'package:themakerspace/src/widgets/appbar.dart';
import 'package:themakerspace/src/widgets/navbar.dart';

class Components extends StatefulWidget {
  const Components({super.key});

  @override
  State<Components> createState() => _ComponentsState();
}

class _ComponentsState extends State<Components> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generateAppbar("Components", true),
      bottomNavigationBar: const Navbar(
        selectedIndex: 0,
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
