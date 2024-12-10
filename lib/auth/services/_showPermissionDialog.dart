// show_permission_dialog.dart
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void showPermissionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Permission Required'),
      content: const Text(
        'This app needs access to your gallery to select a profile picture. Please allow access.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            openAppSettings(); // Open app settings directly
          },
          child: const Text('Open Settings'),
        ),
      ],
    ),
  );
}
