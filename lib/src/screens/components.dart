import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:themakerspace/src/models/building.dart';
import 'package:themakerspace/src/models/component_list.dart';
import 'package:themakerspace/src/providers/api.dart';
import 'package:themakerspace/src/screens/components_subviews.dart';
import 'package:themakerspace/src/utils/componentTree.dart';
import 'package:themakerspace/src/widgets/appbar.dart';
// ignore: depend_on_referenced_packages
import 'package:list_treeview/list_treeview.dart';
import 'package:themakerspace/src/widgets/navbar.dart';

class ComponentsPage extends StatefulWidget {
  const ComponentsPage({super.key});

  @override
  State<ComponentsPage> createState() => _ComponentsPageState();
}

class _ComponentsPageState extends State<ComponentsPage> {
  late TreeViewController _controller;
  @override
  void initState() {
    _controller = TreeViewController();
    getOrSearchComponents("").then((ComponentList value) {
      context.read<ComponentList>().set(value.components, value.suggestions);
      _controller.treeData(generateTree(value));
    });
    // getOrSearchBorrows(null, true, null, {}).then((BorrowList value) {
    //   context.read<BorrowList>().set(value.borrows, value.suggestions);
    // });

    super.initState();
  }

  void delete(dynamic item) {
    _controller.removeItem(item);
  }

  void select(dynamic item) {
    _controller.selectItem(item);
  }

  void selectAllChild(dynamic item) {
    _controller.selectAllChild(item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: generateAppbar(title: "Components", elevate: true, actions: [
          Tooltip(
              message: "Press me to swtich view modes",
              child: IconButton(
                onPressed: () {
                  switchViewModes();
                },
                icon: const Icon(Icons.swap_horiz),
                iconSize: 35,
              )),
        ]),
        bottomNavigationBar: const Navbar(
          selectedIndex: 0,
        ),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: buildListComponentView(context)),
        ));
  }

  void switchViewModes() {}
}
