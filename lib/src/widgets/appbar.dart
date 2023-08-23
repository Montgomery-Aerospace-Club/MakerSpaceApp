import 'package:flutter/material.dart';

AppBar generateAppbar(String title, bool elevate) {
  return AppBar(
    title: Text(title),
    automaticallyImplyLeading: false,
    shadowColor: Colors.grey,
    elevation: elevate ? 2 : 0,
    centerTitle: true,
  );
}
