import 'package:flutter/material.dart';
import 'package:themakerspace/src/extensions/capitalize.dart';
import 'package:themakerspace/src/models/component.dart';

class ComponentListItem extends StatelessWidget {
  final Component component;
  final bool isBorrowed;

  const ComponentListItem(
      {super.key, required this.component, this.isBorrowed = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(component.name.capitalize()),
      subtitle: Text(component.description),
      trailing: SizedBox(
        width: 125,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "Amount: ${component.qty}",
            style: Theme.of(context).textTheme.labelLarge,
          ),
          if (isBorrowed)
            const Tooltip(
                message: "Component is Unavailable",
                child: Icon(
                  Icons.circle,
                  color: Colors.red,
                ))
          else
            const Tooltip(
                message: "Component is Available",
                child: Icon(
                  Icons.circle,
                  color: Colors.green,
                ))
          //TODO maybe add a uuid to component so that barcode
        ]),
      ),
      onTap: () {
        //debugPrint("hi");
      },
      isThreeLine: true,
    );
  }
}
