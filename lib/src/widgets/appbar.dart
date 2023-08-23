import 'package:flutter/material.dart';

AppBar generateAppbar(String title) {
  return AppBar(
    title: Text(title),
    automaticallyImplyLeading: false,
    shadowColor: Colors.grey,
    elevation: 2,
    centerTitle: true,
  );
}
