import 'dart:collection';

import 'package:themakerspace/src/models/component.dart';

class ComponentList with ListMixin<Component> {
  List<Component> components;

  ComponentList({required this.components});

  @override
  int get length => components.length;

  @override
  bool get isEmpty => components.isEmpty;

  @override
  bool get isNotEmpty => components.isNotEmpty;

  @override
  set length(int newLength) {
    components.length = newLength;
  }

  @override
  Component operator [](int index) => components[index];

  @override
  void operator []=(int index, Component value) {
    components[index] = value;
  }

  static Map<String, dynamic> convertToMapDynamic(dynamic item) {
    if (item is Map<String, dynamic>) {
      Map<String, dynamic> converted = {};

      item.forEach((key, value) {
        converted[key] = value;
      });

      return converted;
    }

    return {};
  }

  List<Map<String, dynamic>> toJson() {
    return components.map((e) => e.toJson()).toList();
  }

  factory ComponentList.fromJson(List<dynamic> jsonList) {
    List<Component> components = [];

    List<Map<String, dynamic>> componentsJson =
        jsonList.map((e) => ComponentList.convertToMapDynamic(e)).toList();

    for (Map<String, dynamic> componentJson in componentsJson) {
      if (componentJson.isNotEmpty) {
        components.add(Component.fromJson(componentJson));
      }
    }
    return ComponentList(components: components);
  }
}
