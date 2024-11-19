// pick_image.dart
import 'package:flutter/material.dart';
import 'package:nexplore/services/_showPermissionDialog.dart';
import 'package:nexplore/services/getFromGallery.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> pickImage(BuildContext context) async {
  PermissionStatus status = await Permission.photos.status;

  if (status.isGranted) {
    // If permission is already granted
    getFromGallery(context);
  } else if (status.isDenied || status.isRestricted) {
    // If permission is denied or restricted, request it
    PermissionStatus newStatus = await Permission.photos.request();
    if (newStatus.isGranted) {
      getFromGallery(context); // Retry opening gallery
    } else {
      // Permission was denied
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Gallery access is required to select an image. Please allow access.',
          ),
        ),
      );
    }
  } else if (status.isPermanentlyDenied) {
    // Permission is permanently denied, show dialog
    showPermissionDialog(context);
  }
}
