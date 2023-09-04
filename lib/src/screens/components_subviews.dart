import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:themakerspace/src/models/component_list.dart';
import 'package:themakerspace/src/widgets/searchbar.dart';
import 'package:themakerspace/src/widgets/listitems/component_list_item.dart';
import 'package:themakerspace/src/constants.dart';

Widget buildListComponentView(BuildContext context) {
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
