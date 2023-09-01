import 'package:flutter/material.dart';
import 'package:themakerspace/src/extensions/capitalize.dart';
import 'package:themakerspace/src/models/component.dart';

class ComponentListItem extends StatelessWidget {
  final Component component;
  final bool available;

  const ComponentListItem(
      {super.key, required this.component, this.available = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(component.name.capitalize()),
      subtitle: Text(component.description),
      trailing: SizedBox(
        width: 50,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "${component.qty}",
            style: Theme.of(context).textTheme.labelLarge,
          ),
          if (available)
            const Tooltip(
                message: "Component is Available",
                child: Icon(
                  Icons.circle,
                  color: Colors.green,
                ))
          else
            const Tooltip(
                message: "Component is Unavailable",
                child: Icon(
                  Icons.circle,
                  color: Colors.red,
                ))
        ]),
      ),
      onTap: () {
        //debugPrint("hi");
      },
      isThreeLine: true,
    );
  }
}
