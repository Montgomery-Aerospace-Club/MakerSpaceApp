import 'package:flutter/material.dart';
import 'package:themakerspace/src/models/component.dart';

class ComponentListItem extends StatelessWidget {
  final Component component;

  const ComponentListItem({super.key, required this.component});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(component.name),
      subtitle: Text(component.description),
      trailing: Container(
          color: Colors.blue,
          child: SizedBox(
            width: 60,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${component.qty}",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  //TODO create borrows model
                ]),
          )),
      onTap: () {
        debugPrint("hi");
      },
      isThreeLine: true,
    );
  }
}
