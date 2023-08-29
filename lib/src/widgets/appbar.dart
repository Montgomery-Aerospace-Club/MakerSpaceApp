import 'package:flutter/material.dart';

AppBar generateAppbar(
    {required String title,
    required bool elevate,
    List<IconButton>? actions,
    Widget? leading}) {
  return AppBar(
    title: Text(title),
    automaticallyImplyLeading: false,
    shadowColor: Colors.grey,
    elevation: elevate ? 2 : 0,
    centerTitle: true,
    actions: actions,
    leading: leading,
  );
}
