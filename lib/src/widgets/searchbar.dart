import 'package:flutter/material.dart';

import 'package:themakerspace/src/models/component_list.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar(
      {super.key,
      required this.hintTextForBar,
      required this.componentList,
      required this.searchCallback});

  final String hintTextForBar;
  final ComponentList componentList;
  final void Function(String searchQuery) searchCallback;

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  int? selectedComponentIndex;
  var focusNode = FocusNode();
  List<String> usedWords = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (BuildContext context, SearchController controller) {
        controller.addListener(
          () => widget.searchCallback(controller.text),
        );
        return SearchBar(
            hintText: widget.hintTextForBar,
            controller: controller,
            padding: const MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0)),
            onTap: () {
              controller.openView();
            },
            onChanged: (String text) async {
              controller.openView();
            },
            leading: const Icon(Icons.search));
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        final suggestionSet = {...widget.componentList.suggestions};

        return List<ListTile>.generate(suggestionSet.length, (int index) {
          return ListTile(
              title: Text(suggestionSet.elementAt(index).name),
              onTap: () {
                selectedComponentIndex = index;

                controller.closeView(suggestionSet.elementAt(index).name);
                widget.componentList.searchComponent(controller.text);
              });
        });
      },
    );
  }
}
