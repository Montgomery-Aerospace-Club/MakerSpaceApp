import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:themakerspace/src/models/building.dart';
import 'package:themakerspace/src/models/component_list.dart';
import 'package:themakerspace/src/providers/api.dart';
import 'package:themakerspace/src/utils/componentTree.dart';
import 'package:themakerspace/src/widgets/appbar.dart';
// ignore: depend_on_referenced_packages
import 'package:list_treeview/list_treeview.dart';
import 'package:themakerspace/src/widgets/navbar.dart';

import 'package:themakerspace/src/widgets/searchbar.dart';
import 'package:themakerspace/src/widgets/listitems/component_list_item.dart';
import 'package:themakerspace/src/constants.dart';

class ComponentsPage extends StatefulWidget {
  const ComponentsPage({super.key});

  @override
  State<ComponentsPage> createState() => _ComponentsPageState();
}

class _ComponentsPageState extends State<ComponentsPage> {
  late TreeViewController _controller;
  bool mapView = false;

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
              padding: const EdgeInsets.all(10), child: buildTreeView()),
        ));
  }

  void switchViewModes() {}

  Widget buildTreeView() {
    return ListTreeView(
      shrinkWrap: false,
      padding: const EdgeInsets.all(0),
      itemBuilder: (BuildContext context, dynamic data) {
//              double width = MediaQuery.of(context).size.width;
        double offsetX = data.level * 16.0;
        return Container(
          height: 54,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(width: 1, color: Colors.grey))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: offsetX),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: InkWell(
                          splashColor: Colors.amberAccent.withOpacity(1),
                          highlightColor: Colors.red,
                          onTap: () {
                            selectAllChild(data);
                          },
                          child: data.isSelected
                              ? const Icon(
                                  Icons.star,
                                  size: 30,
                                  color: Color(0xFFFF7F50),
                                )
                              : const Icon(
                                  Icons.star_border,
                                  size: 30,
                                  color: Color(0xFFFFDAB9),
                                ),
                        ),
                      ),
                      Text(
                        'level-${data.level}-${data.indexInParent}',
                        // style: TextStyle(
                        //     fontSize: 15, color: getColor(item.level)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${data.name}',
                        // style: TextStyle(color: item.color),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      onTap: (NodeData data) {
        print('index = ${data.index}');
      },
      onLongPress: (data) {
        delete(data);
      },
      controller: _controller,
    );
  }

  Widget buildListComponentView() {
    double appSearchbarPadding = 10;
    return Center(
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
              page: Constants.componentsPageName,
              hintTextForBar: "Search for Components",
              componentList: context.read<ComponentList>(),
              searchCallback: (searchQuery) =>
                  context.read<ComponentList>().searchComponent(searchQuery),
            )),
        Expanded(
            flex: 5,
            child: ListView.builder(
                itemCount: context.watch<ComponentList>().suggestions.length,
                itemBuilder: ((context, index) {
                  var comp = context.read<ComponentList>().suggestions[index];

                  bool available = comp.qty > 0;

                  return ComponentListItem(
                    component: comp,
                    available: available,
                  );
                })))
      ],
    ));
  }
}
