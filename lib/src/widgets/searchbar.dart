import 'package:flutter/material.dart';
import 'package:themakerspace/src/constants.dart';
import 'package:themakerspace/src/extensions/capitalize.dart';
import 'package:themakerspace/src/models/borrow_list.dart';
// import 'package:themakerspace/src/models/component_list.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:themakerspace/src/providers/cookies.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar({
    super.key,
    required this.hintTextForBar,
    required this.componentList,
    required this.searchCallback,
    required this.page,
  });

  final String page;
  final String hintTextForBar;
  final dynamic componentList;
  final void Function(String searchQuery) searchCallback;

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
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
            constraints: const BoxConstraints(
                minWidth: 360.0, maxWidth: double.infinity, minHeight: 56.0),
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
        if (widget.componentList is BorrowList) {
          return List<ListTile>.generate(
              widget.componentList.suggestions.length, (int index) {
            String title =
                "${widget.componentList.suggestions.elementAt(index).component.name}";

            return ListTile(
                title: Text(
                    "${title.capitalize()}     ID: ${widget.componentList.suggestions.elementAt(index).id}"),
                trailing: Text(
                    "Qty borrowed: ${widget.componentList.suggestions.elementAt(index).qty}"),
                textColor:
                    widget.componentList.suggestions.elementAt(index).inProgress
                        ? Colors.purple
                        : Colors.blue,
                subtitle: Text(
                    "Borrowed on ${DateFormat('yyyy-MM-dd - kk:mm').format(widget.componentList.suggestions.elementAt(index).borrowTime.toLocal())}"),
                onTap: () {
                  if (widget.page == Constants.returnFormPageName) {
                    writeSelectedBorrow(
                        widget.componentList.suggestions.elementAt(index));
                  }
                  controller.closeView(title);
                });
          });
        } else {
          // if (widget.componentList is ComponentList)
          return List<ListTile>.generate(
              widget.componentList.suggestions.length, (int index) {
            return ListTile(
                title: Text(
                    widget.componentList.suggestions.elementAt(index).name),
                onTap: () {
                  if (widget.page == Constants.borrowPageName) {
                    writeSelectedComponent(
                        widget.componentList.suggestions.elementAt(index));
                  }
                  controller.closeView(
                      widget.componentList.suggestions.elementAt(index).name);
                });
          });
        }
      },
    );
  }
}
