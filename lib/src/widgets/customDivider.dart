import 'package:flutter/material.dart';

Widget genDivder(String msg) {
  return Row(children: <Widget>[
    Expanded(
      child: Container(
          margin: const EdgeInsets.only(left: 10.0, right: 20.0),
          child: const Divider(
            height: 36,
          )),
    ),
    Text(msg),
    Expanded(
      child: Container(
          margin: const EdgeInsets.only(left: 20.0, right: 10.0),
          child: const Divider(
            height: 36,
          )),
    ),
  ]);
}
