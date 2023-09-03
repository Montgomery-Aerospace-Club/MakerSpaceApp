import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:themakerspace/src/providers/utils.dart';
import 'borrow.dart'; // Assuming you have a Borrow class defined

class BorrowList extends ChangeNotifier with ListMixin<Borrow> {
  List<Borrow> borrows;
  List<Borrow> suggestions;
  List<Borrow> Function(String searchQuery)? customSearchFunction;

  BorrowList({
    required this.borrows,
    required this.suggestions,
  });

  @override
  int get length => borrows.length;

  @override
  bool get isEmpty => borrows.isEmpty;

  @override
  bool get isNotEmpty => borrows.isNotEmpty;

  @override
  set length(int newLength) {
    borrows.length = newLength;
    notifyListeners();
  }

  @override
  Borrow operator [](int index) => borrows[index];

  @override
  void operator []=(int index, Borrow value) {
    borrows[index] = value;
    notifyListeners();
  }

  @override
  void add(Borrow element) {
    borrows.add(element);
    notifyListeners();
  }

  @override
  String toString() {
    return 'BorrowList(borrows: $borrows, suggestions: $suggestions)';
  }

  void set(List<Borrow> borrows, List<Borrow> suggestions) {
    this.borrows = borrows;
    this.suggestions = suggestions;
    notifyListeners();
  }

  void setSuggestions(List<dynamic> suggestions) {
    this.suggestions = suggestions.map((e) => e as Borrow).toList();
    notifyListeners();
  }

  List<Map<String, dynamic>> toJson() {
    return borrows.map((e) => e.toJson()).toList();
  }

  factory BorrowList.fromJson(List<dynamic> jsonList) {
    List<Borrow> borrows = [];

    List<Map<String, dynamic>> borrowsJson =
        jsonList.map((e) => convertToMapDynamic(e)).toList();

    for (Map<String, dynamic> borrowJson in borrowsJson) {
      if (borrowJson.isNotEmpty) {
        Borrow bor = Borrow.fromJson(borrowJson);
        borrows.add(bor);
      }
    }

    return BorrowList(
      borrows: borrows,
      suggestions: borrows,
    );
  }

  void searchBorrow(String searchQuery) {
    if (customSearchFunction != null) {
      suggestions = customSearchFunction!(searchQuery);
    } else {
      suggestions = defaultSearchFunction(searchQuery);
    }
    // components.suggestions =
    //     BorrowList.convertListBorrowToListComponent(suggestions);
    notifyListeners();
  }

  void setSearchFunction(List<Borrow> Function(String searchQuery) func) {
    customSearchFunction = func;
  }

  List<Borrow> defaultSearchFunction(String query) {
    if (query.isEmpty) {
      return borrows;
    }

    List<Borrow> results = [];

    for (Borrow borrow in borrows) {
      if (query.contains(borrow.user.userId.toString()) ||
          // borrow.user.username.contains(query) ||
          query.contains(borrow.user.email) ||
          borrow.component.name.contains(query) ||
          borrow.component.description.contains(query)) {
        results.add(borrow);
      }
    }

    return results;
  }

  // static convertListBorrowToListComponent(List<Borrow> borrows) {
  //   List<Component> components = [];
  //   for (Borrow borrow in borrows) {
  //     components.add(borrow.component);
  //   }
  //   return components;
  // }
}
