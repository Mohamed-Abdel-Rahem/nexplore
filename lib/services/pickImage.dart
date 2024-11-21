import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:nexplore/services/_showPermissionDialog.dart';
import 'package:nexplore/services/getFromGallery.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> pickImage(
  BuildContext context,
  Function(Uint8List) updateImageCallback, // Accept a callback
) async {
  PermissionStatus status = await Permission.photos.status;

  if (status.isGranted) {
    getFromGallery(context, updateImageCallback); // Pass the callback
  } else if (status.isDenied || status.isRestricted) {
    PermissionStatus newStatus = await Permission.photos.request();
    if (newStatus.isGranted) {
      getFromGallery(context, updateImageCallback); // Retry and pass callback
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Gallery access is required to select an image. Please allow access.',
          ),
        ),
      );
    }
  } else if (status.isPermanentlyDenied) {
    showPermissionDialog(context);
  }
}
