import 'package:flutter/material.dart';
import 'package:themakerspace/src/models/component.dart';

class ComponentListItem extends StatelessWidget {
  final Component component;
  const ComponentListItem({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(component.name),
      onTap: () {
        debugPrint("hi");
      },
    );
  }
}
