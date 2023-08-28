import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themakerspace/src/models/component_list.dart';
import 'package:themakerspace/src/widgets/appbar.dart';
import 'package:themakerspace/src/widgets/component_list_item.dart';
import 'package:themakerspace/src/widgets/navbar.dart';
import 'package:themakerspace/src/widgets/searchbar.dart';

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
                      child: const AppSearchBar(
                        hintTextForBar: "Search for Components You Borrowed",
                      )),
                  Expanded(
                      flex: 5,
                      child: ListView.builder(
                          itemCount:
                              context.watch<ComponentList>().suggestions.length,
                          itemBuilder: ((context, index) {
                            return ComponentListItem(
                                component: context
                                    .watch<ComponentList>()
                                    .suggestions[index]);
                          })))
                ],
              ))),
        ));
  }
}
