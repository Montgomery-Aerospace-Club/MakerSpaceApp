import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themakerspace/src/models/component_list.dart';
import 'package:themakerspace/src/providers/api.dart';
import 'package:themakerspace/src/widgets/appbar.dart';
import 'package:themakerspace/src/widgets/listitems/component_list_item.dart';
import 'package:themakerspace/src/widgets/navbar.dart';
import 'package:themakerspace/src/widgets/searchbar.dart';

class ComponentsPage extends StatefulWidget {
  const ComponentsPage({super.key});

  @override
  State<ComponentsPage> createState() => _ComponentsPageState();
}

class _ComponentsPageState extends State<ComponentsPage> {
  final double appSearchbarPadding = 10;

  @override
  void initState() {
    getOrSearchComponents("").then((ComponentList value) {
      context.read<ComponentList>().set(value.components, value.suggestions);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: generateAppbar(title: "Components", elevate: true),
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
                      child: AppSearchBar(
                        hintTextForBar: "Search for Components",
                        componentList: context.read<ComponentList>(),
                        searchCallback: (searchQuery) => context
                            .read<ComponentList>()
                            .searchComponent(searchQuery),
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
                                  .suggestions[index],
                            );
                          })))
                ],
              ))),
        ));
  }
}
