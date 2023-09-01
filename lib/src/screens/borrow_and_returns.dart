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

      setState(() {
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
                  // Text(
                  //   "Option 1 - Barcode",
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .displaySmall
                  //       ?.copyWith(fontSize: 30, fontWeight: FontWeight.bold),
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  Form(
                    key: formKey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 6,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Component ID",
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
                                  return "Enter a valid credit";
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Is this for another person?",
                                      textAlign: TextAlign.center,
                                    ),
                                    Checkbox(
                                        value: forAnotherPeron,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            forAnotherPeron = value ?? false;
                                          });
                                        }),
                                  ],
                                ))),
                      ],
                    ),
                  ),
                ],
              ))),
    );
  }
}
