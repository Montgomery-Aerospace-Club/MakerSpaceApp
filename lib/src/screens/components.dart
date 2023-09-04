import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themakerspace/src/extensions/capitalize.dart';

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
  bool treeView = false;
  bool alreadyLoaded = false;

  @override
  void initState() {
    _controller = TreeViewController();
    getOrSearchComponents("").then((ComponentList value) {
      context.read<ComponentList>().set(value.components, value.suggestions);
    });
    // getOrSearchBorrows(null, true, null, {}).then((BorrowList value) {
    //   context.read<BorrowList>().set(value.borrows, value.suggestions);
    // });

    super.initState();
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
                  setState(() {
                    treeView = !treeView;
                  });
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
              child: treeView ? buildTreeView() : buildListComponentView()),
        ));
  }

  Widget buildTreeView() {
    if (!alreadyLoaded) {
      _controller.treeData(generateTree(context.read<ComponentList>()));
      alreadyLoaded = true;
    }
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
                      if (data.level == 0)
                        InkWell(
                          child: Icon(Icons.apartment,
                              color: data.isSelected ? Colors.blue : null),
                          onTap: () => selectAllChild(data),
                        )
                      else if (data.level == 1)
                        InkWell(
                          child: Icon(Icons.meeting_room,
                              color: data.isSelected ? Colors.blue : null),
                          onTap: () => selectAllChild(data),
                        )
                      else if (data.level == 2)
                        InkWell(
                          child: Icon(Icons.storage_outlined,
                              color: data.isSelected ? Colors.blue : null),
                          onTap: () => selectAllChild(data),
                        )
                      else if (data.level == 3)
                        InkWell(
                          child: Icon(Icons.blinds,
                              color: data.isSelected ? Colors.blue : null),
                          onTap: () => selectAllChild(data),
                        )
                      else if (data.level == 4)
                        InkWell(
                          child: Icon(Icons.build,
                              color: data.isSelected ? Colors.blue : null),
                          onTap: () => selectAllChild(data),
                        ),

                      // Padding(
                      //   padding: const EdgeInsets.only(right: 5),
                      //   child: InkWell(
                      //     splashColor: Colors.amberAccent.withOpacity(1),
                      //     highlightColor: Colors.red,
                      //     onTap: () {
                      //       selectAllChild(data);
                      //     },
                      //     child: data.isSelected
                      //         ? const Icon(
                      //             Icons.star,
                      //             size: 30,
                      //             color: Color(0xFFFF7F50),
                      //           )
                      //         : const Icon(
                      //             Icons.star_border,
                      //             size: 30,
                      //             color: Color(0xFFFFDAB9),
                      //           ),
                      //   ),
                      // ),
                      if (data.level == 0)
                        Text(" Building ${data.indexInParent + 1}:")
                      else if (data.level == 1)
                        Text(" Room ${data.indexInParent + 1}:")
                      else if (data.level == 2)
                        Text(" Storage Unit ${data.indexInParent + 1}:")
                      else if (data.level == 3)
                        Text(" Storage Bin ${data.indexInParent + 1}:")
                      else if (data.level == 4)
                        Text(" Component ${data.indexInParent + 1}:"),
                      // Text(
                      //   'level-${data.level}-${data.indexInParent}',
                      //   // style: TextStyle(
                      //   //     fontSize: 15, color: getColor(item.level)),
                      // ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        data.name.toString().capitalize(),
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
      onTap: (data) {
        //print('index = ${data.index}');
      },
      onLongPress: (data) {
        //delete(item)
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
              loading: false,
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
