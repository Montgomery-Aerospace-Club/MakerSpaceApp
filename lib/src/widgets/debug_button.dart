import 'package:flutter/material.dart';

double debugCellHeight = 50;
double debugCellWidth = 100;

Widget giveMeDebugButton(
  String title,
  Function() onPressedCallback,
) {
  return ElevatedButton(
      onPressed: onPressedCallback,
      child: SizedBox(
          height: debugCellHeight,
          width: debugCellWidth,
          child: Center(child: Text(title))));
}
