import 'package:flutter/material.dart';
import 'package:themakerspace/src/constants.dart';
import 'package:themakerspace/src/extensions/capitalize.dart';
import 'package:themakerspace/src/models/borrow_list.dart';
// import 'package:themakerspace/src/models/component_list.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:themakerspace/src/models/component.dart';
import 'package:themakerspace/src/providers/cookies.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar({
    super.key,
    required this.hintTextForBar,
    required this.componentList,
    required this.searchCallback,
    required this.page,
    required this.loading,
  });

  final String page;
  final bool loading;
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
          () {
            String query = (controller.text.split("|").elementAtOrNull(0) ??
                    controller.text)
                .trim();

            widget.searchCallback(query);
          },
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
                    "Borrowed on ${DateFormat('yyyy-MM-dd - kk:mm').format(widget.componentList.suggestions.elementAt(index).borrowTime)}"),
                onTap: () {
                  if (widget.page == Constants.returnFormPageName) {
                    writeSelectedBorrow(
                        widget.componentList.suggestions.elementAt(index));
                  }
                  controller.closeView(
                      "${title.capitalize()} | Borrow Qty: ${widget.componentList.suggestions.elementAt(index).qty} | Borrow ID:${widget.componentList.suggestions.elementAt(index).id}");
                });
          });
        } else {
          // if (widget.componentList is ComponentList)

          return List<ListTile>.generate(
              widget.componentList.suggestions.length, (int index) {
            Component comp = widget.componentList.suggestions.elementAt(index);

            String name = comp.name;

            return ListTile(
                title: Text(name.capitalize()),
                subtitle: Text("ID: ${comp.id}"),
                trailing: Text("Qty in stock: ${comp.qty}"),
                onTap: () {
                  if (widget.page == Constants.borrowPageName) {
                    writeSelectedComponent(comp);
                  }
                  controller
                      .closeView("${comp.name.capitalize()} | ID: ${comp.id}");
                });
          });
        }
      },
    );
  }
}
