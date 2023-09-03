import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:themakerspace/src/constants.dart';
import 'package:themakerspace/src/extensions/darkmode.dart';
import 'package:themakerspace/src/models/component.dart';
import 'package:themakerspace/src/models/component_list.dart';
import 'package:themakerspace/src/models/user.dart';
import 'package:themakerspace/src/providers/api.dart';
import 'package:themakerspace/src/providers/cookies.dart';
import 'package:themakerspace/src/widgets/customSnackBars.dart';

import 'package:themakerspace/src/widgets/searchbar.dart';

import '../customDivider.dart';

class BorrowForm extends StatefulWidget {
  const BorrowForm({super.key});

  @override
  State<BorrowForm> createState() => _BFormState();
}

class _BFormState extends State<BorrowForm> {
  var formKey = GlobalKey<FormState>();
  String componentID = "";
  String username = "";
  String password = "";
  bool loading = false;
  bool useSearch = false;
  int qty = 1;

  bool isNumeric(String s) {
    // ignore: unnecessary_null_comparison
    if (s == null) {
      return false;
    }
    return int.tryParse(s) != null;
  }

  InputDecoration textFieldDeco(String hintText, Icon? aicon) {
    return InputDecoration(
      prefixIcon: aicon,
      hintText: hintText,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
      filled: true,
      fillColor: context.isDarkMode
          ? Theme.of(context).colorScheme.onSecondary.withAlpha(170)
          : Theme.of(context).colorScheme.primary.withOpacity(0.1),
    );
  }

  Future<void> submit() async {
    User user = await readUser();

    if (!mounted) return;

    String msg = "Error 6969 - Consult Eddie";

    if (useSearch) {
      Component comp = await readSearchBarComponent();
      msg = await createBorrow(qty.toString(), user, DateTime.now(), comp.url);
    } else {
      String url = "${Constants.apiUrl}/rest/components/$componentID/";
      msg = await createBorrow(qty.toString(), user, DateTime.now(), url);
    }

    if (!mounted) return;

    if (msg.isEmpty) {
      displaySuccessMsg(context, "Borrow");
    } else {
      displayErrorMessage(msg, context);
    }

    setState(() {
      formKey.currentState?.reset();
    });
    setState(() {
      loading = false;
    });
    await resetSelectedComponent();

    var compList = await getOrSearchComponents("");

    if (!mounted) return;
    context
        .read<ComponentList>()
        .set(compList.components, compList.suggestions);
  }

  void confirm() async {
    formKey.currentState!.save();

    Component comp = await readSearchBarComponent();
    if (comp.mpn != "6969" && comp.sku != "6969" && comp.name.isNotEmpty) {
      setState(() {
        useSearch = true;
      });
    }
    if (!mounted) return;

    if (formKey.currentState!.validate()) {
      showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              title: const Text("Submit borrow request for component?"),
              actions: [
                ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();

                      setState(() {
                        loading = true;
                      });

                      await submit();
                    },
                    child: const SizedBox(child: Text("Yes"))),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () => Navigator.pop(context),
                    child: const SizedBox(
                        child:
                            Text("No", style: TextStyle(color: Colors.white)))),
              ],
            );
          }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Row(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppSearchBar(
                      page: Constants.borrowPageName,
                      hintTextForBar: "Search for Components",
                      componentList: context.read<ComponentList>(),
                      searchCallback: (searchQuery) => context
                          .read<ComponentList>()
                          .searchComponent(searchQuery),
                    ),
                    genDivder("OR"),
                    TextFormField(
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.number,
                      decoration: textFieldDeco(
                          "Click me, Then scan your barcode",
                          const Icon(Icons.barcode_reader)),
                      onFieldSubmitted: (value) => confirm(),
                      validator: (v) {
                        if (useSearch) {
                          return null;
                        }

                        if (v!.isEmpty) {
                          return "Enter an ID";
                        } else if (!isNumeric(v)) {
                          return "Enter a valid ID (number)";
                        } else {
                          setState(() {
                            componentID = v;
                          });
                          return null;
                        }
                      },
                      // onFieldSubmitted: (value) => submit(),
                    ),
                  ],
                )),
            loading
                ? const CircularProgressIndicator()
                : Expanded(
                    child: IconButton(
                    tooltip: "Submit borrow request",
                    onPressed: () => confirm(),
                    icon: const Icon(Icons.arrow_forward_ios),
                  )),
          ],
        ));
  }
}
