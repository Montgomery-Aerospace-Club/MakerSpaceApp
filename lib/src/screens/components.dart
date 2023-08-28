import 'package:flutter/material.dart';
import 'package:themakerspace/src/widgets/appbar.dart';
import 'package:themakerspace/src/widgets/navbar.dart';

class ComponentsPage extends StatefulWidget {
  const ComponentsPage({super.key});

  @override
  State<ComponentsPage> createState() => _ComponentsState();
}

class _ComponentsState extends State<ComponentsPage> {
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
