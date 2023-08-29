import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themakerspace/src/models/borrow_list.dart';
import 'package:themakerspace/src/providers/api.dart';
import 'package:themakerspace/src/providers/cookies.dart';
import 'package:themakerspace/src/screens/login.dart';
import 'package:themakerspace/src/widgets/appbar.dart';
import 'package:themakerspace/src/widgets/listitems/borrow_list_item.dart';
import 'package:themakerspace/src/widgets/navbar.dart';
import 'package:themakerspace/src/widgets/searchbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final double appSearchbarPadding = 10;

  @override
  void initState() {
    readUser().then((value) {
      getOrSearchBorrows(value.username, null).then((BorrowList value) {
        context
            .read<BorrowList>()
            .set(value.borrows, value.suggestions, value.components);
        //print(context.read<BorrowList>().suggestions);
      });

      // print(context.read<BorrowList>().suggestions);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: generateAppbar(title: "Home", elevate: true, actions: [
          IconButton(
              onPressed: () {
                logout();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Login()));
              },
              icon: const Icon(Icons.logout))
        ]),
        bottomNavigationBar: const Navbar(
          selectedIndex: 1,
        ),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          top: appSearchbarPadding,
                          bottom: appSearchbarPadding,
                          left: appSearchbarPadding + 5,
                          right: appSearchbarPadding + 5),
                      child: AppSearchBar(
                        hintTextForBar: "Search for Components You Borrowed",
                        componentList: context.read<BorrowList>().components,
                        searchCallback: (searchQuery) => context
                            .read<BorrowList>()
                            .searchBorrow(searchQuery),
                      )),
                  Expanded(
                      flex: 5,
                      child: ListView.builder(
                          itemCount:
                              context.watch<BorrowList>().suggestions.length,
                          itemBuilder: ((context, index) {
                            //TODO: try to add some more actual UI to the borrow list item that uses its attributes to the fullest
                            //TODO: implement sign in and sign out model in db and in app
                            //TODO: Implement borrow and return system
                            //TODO: discuss about the qty and how do implement qty reduce after borrow post request is accepted in server

                            /*
                             return {
                                "url": url,
                                'person_who_borrowed': user.toJson(),
                                'timestamp_check_out': borrowTime.toIso8601String(),
                                'timestamp_check_in': returnTime?.toIso8601String(),
                                "borrow_in_progress": inProgress,
                                "component": component.toJson(),
                              };
                            */
                            return BorrowListItem(
                              component: context
                                  .watch<BorrowList>()
                                  .suggestions[index],
                            );
                          })))
                ],
              ))),
        ));
  }
}
