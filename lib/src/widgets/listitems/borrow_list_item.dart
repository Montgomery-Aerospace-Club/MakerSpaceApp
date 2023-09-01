import 'package:flutter/material.dart';
import 'package:themakerspace/src/extensions/capitalize.dart';
import 'package:themakerspace/src/models/borrow.dart';

class BorrowListItem extends StatelessWidget {
  final Borrow component;
  final bool isBorrowInProgress;

  const BorrowListItem(
      {super.key, required this.component, this.isBorrowInProgress = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(component.component.name.capitalize()),
      subtitle: Text(component.component.description),
      trailing:
          //Container(
          //color: Colors.blue,
          //child:
          SizedBox(
        width: 200,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "Amount Borrowed: ${component.qty}",
            style: Theme.of(context).textTheme.labelLarge,
          ),
          if (isBorrowInProgress)
            const Tooltip(
                message: "Component is being borrowed by you",
                child: Icon(
                  Icons.circle,
                  color: Colors.purple,
                ))
          else
            const Tooltip(
                message: "Component has been returned",
                child: Icon(
                  Icons.circle,
                  color: Colors.blue,
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
