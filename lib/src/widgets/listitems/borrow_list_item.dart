import 'package:flutter/material.dart';
import 'package:themakerspace/src/extensions/capitalize.dart';
import 'package:themakerspace/src/models/borrow.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class BorrowListItem extends StatelessWidget {
  final Borrow component;
  final bool isBorrowInProgress;

  const BorrowListItem(
      {super.key, required this.component, this.isBorrowInProgress = false});

  @override
  Widget build(BuildContext context) {
    String subtitle = "";
    subtitle += "${component.component.description}\n";
    subtitle +=
        "Borrowed on ${DateFormat('yyyy-MM-dd - kk:mm').format(component.borrowTime.toLocal())}\n";

    subtitle +=
        "Returned on ${component.returnTime != null ? DateFormat('yyyy-MM-dd - kk:mm').format(component.returnTime!.toLocal()) : "N/A"}\n";

    return ListTile(
      title: Text(component.component.name.capitalize()),
      subtitle: Text(subtitle),
      trailing:
          //Container(
          //color: Colors.blue,
          //child:
          SizedBox(
        width: 175,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "Qty Borrowed: ${component.qty}\nBorrow ID: ${component.id}",
            textAlign: TextAlign.end,
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
