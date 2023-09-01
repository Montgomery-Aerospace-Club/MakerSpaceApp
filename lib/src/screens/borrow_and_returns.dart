import 'package:flutter/material.dart';
import 'package:themakerspace/src/widgets/appbar.dart';
import 'package:themakerspace/src/widgets/navbar.dart';

class BRs extends StatefulWidget {
  const BRs({super.key});

  @override
  State<BRs> createState() => _BRsState();
}

class _BRsState extends State<BRs> {
  var formKey = GlobalKey<FormState>();
  String componentID = "";
  bool forAnotherPeron = false;

  bool isNumeric(String s) {
    // ignore: unnecessary_null_comparison
    if (s == null) {
      return false;
    }
    return int.tryParse(s) != null;
  }

  void submit() {
    formKey.currentState!.save();
    if (formKey.currentState!.validate()) {
      //TODO: logic over here
      print(componentID);
      print(forAnotherPeron);

      setState(() {
        forAnotherPeron = false;
        formKey.currentState?.reset();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: generateAppbar(title: "Borrow and Return", elevate: true),
      bottomNavigationBar: const Navbar(
        selectedIndex: 2,
      ),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: TextFormField(
                                    textAlign: TextAlign.left,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: "Search from your borrows",
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          borderSide: BorderSide.none),
                                      filled: true,
                                      fillColor: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.3),
                                    ),
                                    validator: (v) {
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
                                    onFieldSubmitted: (value) => submit(),
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "Is this for another person?",
                                            textAlign: TextAlign.center,
                                          ),
                                          Checkbox(
                                              value: forAnotherPeron,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  forAnotherPeron =
                                                      value ?? false;
                                                });
                                              }),
                                        ],
                                      ))),
                            ],
                          ),
                          TextFormField(
                            textAlign: TextAlign.left,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Scan the barcode",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                  borderSide: BorderSide.none),
                              filled: true,
                              fillColor: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.3),
                            ),
                            validator: (v) {
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
                            onFieldSubmitted: (value) => submit(),
                          ),
                        ],
                      )),
                ],
              ))),
    );
  }
}
