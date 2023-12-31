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

import '../../screens/borrow_and_returns.dart';
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
  int tens = 0;
  int digits = 1;

  var qtyFormKey = GlobalKey<FormState>();

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
      msg = await createBorrow("$tens$digits", user, DateTime.now(), comp.url);
    } else {
      String url = "${Constants.apiUrl}/rest/components/$componentID/";
      msg = await createBorrow("$tens$digits", user, DateTime.now(), url);
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
      useSearch = false;
    });
    await resetSelectedComponent();

    var compList = await getOrSearchComponents("");

    if (!mounted) return;
    context
        .read<ComponentList>()
        .set(compList.components, compList.suggestions);

    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => const BRs()));
  }

  void confirm() async {
    formKey.currentState!.save();

    Component comp = await readSearchBarComponent();
    // if the user not using search, it will give a defauly value
    // else the user is using search ,it will give  acustom value, so we need to set userSearch to true
    if (comp.mpn != "6969" ||
        comp.sku != "6969" ||
        comp.name.isNotEmpty ||
        comp.id != "-1") {
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
                      setState(() {
                        loading = true;
                      });
                      Navigator.of(context).pop();

                      await submit();
                    },
                    child: const SizedBox(child: Text("Yes"))),
                ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      setState(() {
                        loading = false;
                      });
                      Navigator.pop(context);
                    },
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
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppSearchBar(
                      loading: loading,
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
            Expanded(
                flex: 2,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Amount you will borrow:  ",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  fontSize: 15,
                                ),
                          ),
                          Tooltip(
                              message: "Click me to edit",
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: ((context) {
                                        return AlertDialog(
                                          title: const Text(
                                              "Edit amount you will borrow"),
                                          content: Form(
                                            key: qtyFormKey,
                                            child: TextFormField(
                                              decoration: textFieldDeco(
                                                  "Enter your qty", null),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return "Enter a number";
                                                } else if (!isNumeric(value)) {
                                                  return "Enter a valid number";
                                                } else if (value.length > 3 ||
                                                    1 > int.parse(value)) {
                                                  return "Enter a valid number between 1-99";
                                                }

                                                setState(() {
                                                  if (value.length == 1) {
                                                    tens = 0;
                                                    digits =
                                                        int.parse(value[0]);
                                                  } else {
                                                    tens = int.parse(value[0]);
                                                    digits =
                                                        int.parse(value[1]);
                                                  }
                                                });

                                                return null;
                                              },
                                            ),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  qtyFormKey.currentState!
                                                      .save();
                                                  if (qtyFormKey.currentState!
                                                      .validate()) {
                                                    qtyFormKey.currentState
                                                        ?.reset();
                                                  }
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Done")),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Cancel"))
                                          ],
                                        );
                                      }));
                                },
                                child: Text(
                                  "$tens$digits",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(
                                        fontSize: 50,
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                ),
                              )),
                        ],
                      ),
                    ])),
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
