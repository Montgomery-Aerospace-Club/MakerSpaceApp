import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themakerspace/src/constants.dart';
import 'package:themakerspace/src/extensions/darkmode.dart';
import 'package:themakerspace/src/models/borrow_list.dart';
import 'package:themakerspace/src/providers/api.dart';
import 'package:themakerspace/src/providers/cookies.dart';
import 'package:themakerspace/src/widgets/searchbar.dart';

class BRForm extends StatefulWidget {
  const BRForm({super.key, required this.isReturnForm});

  final bool isReturnForm;

  @override
  State<BRForm> createState() => _BRFormState();
}

class _BRFormState extends State<BRForm> {
  var formKey = GlobalKey<FormState>();
  String componentID = "";
  bool forAnotherPeron = false;
  String username = "";
  String password = "";
  bool loading = false;

  void displayErrorMessage(String msg) {
    //display the error msg
    final snackBar = SnackBar(
        duration: const Duration(milliseconds: 5000),
        backgroundColor: Colors.red,
        content:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Row(children: [
            Icon(Icons.error),
            Text(
              " Error",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            ),
          ]),
          Text(msg)
        ]));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

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
    String token = await readToken();
    if (forAnotherPeron) {
      token = await login(username, password, true);
      print(username);
      print(password);
      print(token);
    }
    String url = "${Constants.apiUrl}/rest/borrows/-1/";

    if (!mounted) return;

    if (context.read<BorrowList>().suggestions.length == 1) {
      url = context.read<BorrowList>().suggestions.first.url;
    } else {
      url = "${Constants.apiUrl}/rest/borrows/$componentID/";
    }

    // return api
    String msg =
        await returnBorrowWithUrl(DateTime.now(), null, false, url, token);

    if (msg.isEmpty) {
      //display success message
    } else {
      //display error msg with erorr msg being msg
      displayErrorMessage(msg);
    }

    setState(() {
      forAnotherPeron = false;
      formKey.currentState?.reset();
    });
  }

  void confirm() {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      showDialog(
          context: context,
          builder: ((context) {
            return AlertDialog(
              actionsAlignment: MainAxisAlignment.center,
              title: const Text("Submit borrow/return request for component?"),
              actions: [
                ElevatedButton(
                    onPressed: () async {
                      await submit();

                      if (!mounted) return;

                      Navigator.of(context).pop();
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
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Form(
            key: formKey,
            child: Row(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppSearchBar(
                      hintTextForBar: "Search for Components YOU Borrowed",
                      componentList: context.read<BorrowList>().components,
                      searchCallback: (searchQuery) =>
                          context.read<BorrowList>().searchBorrow(searchQuery),
                    ),
                    Row(children: <Widget>[
                      Expanded(
                        child: Container(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 20.0),
                            child: const Divider(
                              height: 36,
                            )),
                      ),
                      const Text("OR"),
                      Expanded(
                        child: Container(
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 10.0),
                            child: const Divider(
                              height: 36,
                            )),
                      ),
                    ]),
                    TextFormField(
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.number,
                      decoration: textFieldDeco("Click me, Then scan a barcode",
                          const Icon(Icons.barcode_reader)),
                      validator: (v) {
                        if (context.read<BorrowList>().suggestions.length ==
                            1) {
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
                    child: Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Is this for another person?",
                              textAlign: TextAlign.center,
                            ),
                            Tooltip(
                              message:
                                  "Check this box if you are using another person's account to return an item\nor if you are returning an item borrowed by another person",
                              child: Checkbox(
                                  value: forAnotherPeron,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      forAnotherPeron = value ?? false;
                                    });
                                  }),
                            ),
                          ],
                        )),
                    Row(
                      children: [
                        const Spacer(),
                        Expanded(
                            flex: 3,
                            child: Tooltip(
                                message:
                                    "Only enter into this field if you checked the box above",
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  decoration: textFieldDeco("Username", null),
                                  validator: (v) {
                                    if (forAnotherPeron) {
                                      if (v!.isEmpty) {
                                        return "Enter a username";
                                      } else {
                                        setState(() {
                                          username = v;
                                        });
                                        return null;
                                      }
                                    }
                                    return null;
                                  },
                                ))),
                        const Spacer(),
                        Expanded(
                            flex: 3,
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: textFieldDeco("Password", null),
                              validator: (v) {
                                if (forAnotherPeron) {
                                  if (v!.isEmpty) {
                                    return "Enter a password";
                                  } else {
                                    setState(() {
                                      password = v;
                                    });
                                    return null;
                                  }
                                }
                                return null;
                              },
                            )),
                        const Spacer(),
                      ],
                    ),
                  ],
                )),
              ],
            )),
        const SizedBox(
          height: 30,
        ),
        loading
            ? const CircularProgressIndicator()
            : IconButton(
                tooltip: "Submit return request",
                onPressed: () => confirm(),
                icon: const Icon(Icons.arrow_forward_ios),
              ),
      ],
    );
  }
}
