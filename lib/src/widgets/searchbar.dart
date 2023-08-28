import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themakerspace/src/models/component_list.dart';
import 'package:themakerspace/src/providers/api.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar({super.key, required this.hintTextForBar});

  final String hintTextForBar;

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  int? selectedComponentIndex;
  var focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getComponents().then((value) {
      context.read<ComponentList>().set(value.components, value.suggestions);
      return value;
    });
    return SearchAnchor(
      builder: (BuildContext context, SearchController controller) {
        controller.addListener(
          () => context.read<ComponentList>().searchComponent(controller.text),
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
        return List<ListTile>.generate(
            context.read<ComponentList>().suggestions.length, (int index) {
          return ListTile(
              title:
                  Text(context.read<ComponentList>().suggestions[index].name),
              onTap: () {
                selectedComponentIndex = index;

                controller.closeView(
                    context.read<ComponentList>().suggestions[index].name);
                context.read<ComponentList>().searchComponent(controller.text);
              });
        });
      },
    );
  }
}
