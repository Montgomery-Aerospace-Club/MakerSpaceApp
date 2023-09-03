import 'package:flutter/material.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:provider/provider.dart';
import 'package:themakerspace/src/constants.dart';
import 'package:themakerspace/src/extensions/darkmode.dart';
import 'package:themakerspace/src/models/borrow.dart';
import 'package:themakerspace/src/models/borrow_list.dart';
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

    String url = "${Constants.apiUrl}/rest/borrows/-1/";

    if (!mounted) return;

    if (useSearch) {
      Borrow bor = await readSearchBarBorrow();
      url = bor.url;
      String msg =
          await returnBorrowWithUrl(DateTime.now(), null, false, url, token);

      if (!mounted) return;

      if (msg.isEmpty) {
        displaySuccessMsg(context, "Return");
      } else {
        displayErrorMessage(msg, context);
      }

      setState(() {
        formKey.currentState?.reset();
      });
    } else {
      BorrowList bors = await getOrSearchBorrows(null, true, componentID, {});
      if (!mounted) return;
      if (bors.isNotEmpty) {
        Borrow selectedBor = bors.borrows.first;
        showMaterialRadioPicker<Borrow>(
          context: context,
          title: 'Please pick your borrow reciept.',
          items: bors.borrows,
          selectedItem: selectedBor,
          onChanged: (value) => setState(() => selectedBor = value),
          onConfirmed: () async {
            url = selectedBor.url;
            String msg = await returnBorrowWithUrl(
                DateTime.now(), null, false, url, token);

            if (!mounted) return;

            if (msg.isEmpty) {
              displaySuccessMsg(context, "Return");
            } else {
              displayErrorMessage(msg, context);
            }

            setState(() {
              formKey.currentState?.reset();
            });
          },
        );
      }
    }
    setState(() {
      loading = false;
    });
    await resetSelectedBorrow();

    var value = await readUser();

    var borList = await getOrSearchBorrows(value.username, true, null, {});

    if (!mounted) return;
    context.read<BorrowList>().set(borList.borrows, borList.suggestions);
  }

  void confirm() async {
    formKey.currentState!.save();

    if (context.read<BorrowList>().suggestions.length == 1) {
      setState(() {
        useSearch = true;
      });
    }

    Borrow bor = await readSearchBarBorrow();
    if (bor.url.isNotEmpty) {
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
              title: const Text("Submit borrow/return request for component?"),
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
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppSearchBar(
                  page: Constants.returnFormPageName,
                  hintTextForBar: "Search for Components YOU Borrowed",
                  componentList: context.read<BorrowList>(),
                  searchCallback: (searchQuery) =>
                      context.read<BorrowList>().searchBorrow(searchQuery),
                ),
                genDivder("OR"),
                TextFormField(
                  textAlign: TextAlign.left,
                  keyboardType: TextInputType.number,
                  decoration: textFieldDeco("Click me, Then scan a barcode",
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
            const SizedBox(
              height: 30,
            ),
            loading
                ? const CircularProgressIndicator()
                : IconButton(
                    tooltip: "Submit borrow request",
                    onPressed: () => confirm(),
                    icon: const Icon(Icons.arrow_forward_ios),
                  ),
          ],
        ));
  }
}
