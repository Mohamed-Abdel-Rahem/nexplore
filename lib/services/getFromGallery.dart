import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

Future<void> getFromGallery(
  BuildContext context,
  Function(Uint8List) updateImageCallback, // Accept a callback
) async {
  try {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final Uint8List imageData = await pickedFile.readAsBytes();
      updateImageCallback(imageData); // Update the image using the callback
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error picking image: $e')),
    );
  }
}
