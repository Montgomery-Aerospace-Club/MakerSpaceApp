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
      trailing: Container(
          //color: Colors.blue,
          child: SizedBox(
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
          //TODO integrate borrows list model
          //TODO maybe add a uuid to component and borrow so that searching is ok cuz patch then it will patch all the exisitng ones
          //TODO maybe not uuid cuz i can just add a field inprogress = true hm
        ]),
      )),
      onTap: () {
        debugPrint("hi");
      },
      isThreeLine: true,
    );
  }
}
