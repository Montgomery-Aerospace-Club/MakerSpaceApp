import 'package:flutter/material.dart';

AppBar generateAppbar() {
  return AppBar(
    title: const Text(""),
    automaticallyImplyLeading: false,
    actions: [
      Padding(
          padding: const EdgeInsets.all(1),
          child: IconButton(
              onPressed: () {}, icon: const Icon(Icons.camera_alt_rounded)))
    ],
    shadowColor: Colors.grey,
    elevation: 2,
  );
}
