import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themakerspace/src/models/borrow_list.dart';
import 'package:themakerspace/src/providers/api.dart';
import 'package:themakerspace/src/widgets/appbar.dart';
import 'package:themakerspace/src/widgets/borrowReturnForm.dart';
import 'package:themakerspace/src/widgets/navbar.dart';

class BRs extends StatefulWidget {
  const BRs({super.key});

  @override
  State<BRs> createState() => _BRsState();
}

class _BRsState extends State<BRs> {
  @override
  void initState() {
    getOrSearchBorrows(null, true, null, {"ordering": "-borrow_in_progress"})
        .then((BorrowList value) {
      context
          .read<BorrowList>()
          .set(value.borrows, value.suggestions, value.components);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generateAppbar(title: "Borrow and Return", elevate: true),
      bottomNavigationBar: const Navbar(
        selectedIndex: 2,
      ),
      body: const SafeArea(
          child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [BRForm(isReturnForm: true)],
              ))),
    );
  }
}
