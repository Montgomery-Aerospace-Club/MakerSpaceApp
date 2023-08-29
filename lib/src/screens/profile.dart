import 'package:flutter/material.dart';
import 'package:themakerspace/src/providers/cookies.dart';

void showUserDialog(BuildContext context) async {
  readUser().then((value) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Profile 🛠️"),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("User id:"),
                trailing: Text(
                  "${value.userId}",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("Username:"),
                trailing: Text(
                  value.username,
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("Email:"),
                trailing: Text(
                  "${value.email.split("@")[0]}\n@${value.email.split("@")[1]}",
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.end,
                ),
              ),
            ]),
          );
        });
  });
}
