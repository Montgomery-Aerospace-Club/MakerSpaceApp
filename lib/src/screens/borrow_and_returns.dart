import 'package:flutter/material.dart';
import 'package:themakerspace/src/widgets/appbar.dart';
import 'package:themakerspace/src/widgets/navbar.dart';

class BRs extends StatefulWidget {
  const BRs({super.key});

  @override
  State<BRs> createState() => _BRsState();
}

class _BRsState extends State<BRs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generateAppbar("Borrow and Return", true),
      bottomNavigationBar: const Navbar(
        selectedIndex: 2,
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
