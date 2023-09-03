import 'package:flutter/material.dart';

void displayErrorMessage(String msg, BuildContext context) {
  //display the error msg
  final snackBar = SnackBar(
      duration: const Duration(milliseconds: 5000),
      backgroundColor: Colors.red,
      content: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(children: [
          Icon(Icons.error),
          Text(
            " Error",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
        ]),
        Text(msg)
      ]));

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void displaySuccessMsg(BuildContext context) {
  //display the succs msg
  const snackBar = SnackBar(
    duration: Duration(milliseconds: 2000),
    backgroundColor: Colors.green,
    content: Row(children: [
      Icon(Icons.check),
      Text(
        " Success ",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
      ),
    ]),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
