import 'package:flutter/material.dart';
import 'package:monty_makerspace/src/widgets/appbar.dart';
import 'package:monty_makerspace/src/widgets/navbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generateAppbar("Home"),
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
