import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themakerspace/src/models/component_list.dart';
import 'package:themakerspace/src/providers/cookies.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar({super.key});

  // final BuildContext providerContext;

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  ComponentList _components = ComponentList(components: [], suggestions: []);
  int? selectedComponentIndex;
  String? searchFieldText;

  //searchComponents(text)

  void search() async {
    print(searchFieldText);

    Provider.of<ComponentList>(context, listen: false)
        .searchComponent(searchFieldText ?? "");

    print(_components.suggestions);
  }

  @override
  void initState() {
    readComponentList().then((value) {
      _components = value;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (BuildContext context, SearchController controller) {
        controller.addListener(
          () {
            searchFieldText = controller.text;
          },
        );
        return SearchBar(
            hintText: "Search for Components Borrowed",
            controller: controller,
            padding: const MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0)),
            onTap: () {
              controller.openView();
            },
            onChanged: (String text) async {
              controller.openView();
            },
            trailing: [
              IconButton(
                  onPressed: () => search(),
                  icon: const Icon(Icons.arrow_forward))
            ],
            leading: const Icon(Icons.search));
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        Consumer<ComponentList> con = Consumer<ComponentList>(
          builder: (context, viewModel, child) {
            return ListView.builder(
                itemCount: viewModel.suggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                      title: Text(_components.suggestions[index].name),
                      onTap: () {
                        selectedComponentIndex = index;
                        setState(() {
                          controller
                              .closeView(_components.suggestions[index].name);
                        });
                      });
                });
          },
        );

        List<ListTile>.generate(_components.suggestions.length, (int index) {
          return ListTile(
              title: Text(_components.suggestions[index].name),
              onTap: () {
                selectedComponentIndex = index;
                setState(() {
                  controller.closeView(_components.suggestions[index].name);
                });
              });
        });
        //TODO finish this - https://petercoding.com/flutter/2021/07/11/using-provider-in-flutter/

        return [con];
      },
    );
  }
}
