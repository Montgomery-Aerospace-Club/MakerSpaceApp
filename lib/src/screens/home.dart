import 'package:flutter/material.dart';
import 'package:monty_makerspace/src/widgets/appbar.dart';
import 'package:monty_makerspace/src/widgets/navbar.dart';
import 'package:monty_makerspace/src/widgets/searchbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final double appSearchbarPadding = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generateAppbar("Home", true),
      bottomNavigationBar: const Navbar(
        selectedIndex: 1,
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          top: appSearchbarPadding,
                          bottom: appSearchbarPadding,
                          left: appSearchbarPadding + 5,
                          right: appSearchbarPadding + 5),
                      child: const AppSearchBar())
                ],
              )))),
    );
  }
}
