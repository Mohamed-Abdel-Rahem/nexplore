// get_from_gallery.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

Future<void> getFromGallery(BuildContext context) async {
  try {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final Uint8List imageData = await pickedFile.readAsBytes();
      // Here, you can update the state of the parent widget with the selected image.
      // For now, let's assume you have a function to do that (e.g., _updateImage)
      _updateImage(imageData, context);
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error picking image: $e')),
    );
  }
}

// Assuming the parent widget has a method to update the image.
void _updateImage(Uint8List imageData, BuildContext context) {
  // Implement the image update logic, for example using a state management solution.
}
