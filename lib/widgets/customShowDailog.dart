import 'package:flutter/material.dart';

Widget CustomShowDailog({required BuildContext context}) {
  return AlertDialog(
    title: const Text('Delete Account'),
    content: const Text('Are you sure you want to delete your account?'),
    actions: <Widget>[
      TextButton(
        onPressed: () => Navigator.of(context).pop(false),
        child: const Text('No'),
      ),
      TextButton(
        onPressed: () => Navigator.of(context).pop(true),
        child: const Text('Yes'),
      ),
    ],
  );
}
