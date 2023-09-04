import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:themakerspace/src/models/component.dart';
import 'package:themakerspace/src/providers/utils.dart';

class ComponentList extends ChangeNotifier with ListMixin<Component> {
  List<Component> components;
  List<Component> suggestions;
  List<Component> Function(String searchQuery)? customSearchFunction;

  ComponentList({required this.components, required this.suggestions});

  @override
  int get length => components.length;

  @override
  bool get isEmpty => components.isEmpty;

  @override
  bool get isNotEmpty => components.isNotEmpty;

  @override
  set length(int newLength) {
    components.length = newLength;
    notifyListeners();
  }

  @override
  Component operator [](int index) => components[index];

  @override
  void operator []=(int index, Component value) {
    components[index] = value;
    notifyListeners();
  }

  @override
  String toString() {
    return 'ComponentList(components: $components, suggestions: $suggestions)';
  }

  void set(List<Component> components, List<Component> suggestions) {
    this.components = components;
    this.suggestions = suggestions;
    notifyListeners();
  }

  List<Map<String, dynamic>> toJson() {
    return components.map((e) => e.toJson()).toList();
  }

  factory ComponentList.fromJson(List<dynamic> jsonList) {
    List<Component> components = [];

    List<Map<String, dynamic>> componentsJson =
        jsonList.map((e) => convertToMapDynamic(e)).toList();

    for (Map<String, dynamic> componentJson in componentsJson) {
      if (componentJson.isNotEmpty) {
        components.add(Component.fromJson(componentJson));
      }
    }
    return ComponentList(components: components, suggestions: components);
  }

  void searchComponent(String searchQuery) {
    searchQuery = searchQuery.toLowerCase();
    if (customSearchFunction != null) {
      suggestions = customSearchFunction!(searchQuery);
    } else {
      suggestions = defaultSearchFunction(searchQuery);
    }
    notifyListeners();
    return;
  }

  void setSearchFunction(List<Component> Function(String searchQuery) func) {
    customSearchFunction = func;
  }

  List<Component> defaultSearchFunction(String query) {
    if (query.isEmpty) {
      return components;
    }

    List<Component> results = [];

    for (Component comp in components) {
      if (comp.name.toLowerCase().contains(query) ||
          comp.description.toLowerCase().contains(query)) {
        results.add(comp);
      }
    }

    return results;
  }
}
