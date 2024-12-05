import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:nexplore/utils/extension/contextExtension.dart'; // Add this dependency

Future<void> pickImageAndSave(
  BuildContext context,
  Function(Uint8List) updateImageCallback,
) async {
  try {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      Uint8List imageData = await pickedFile.readAsBytes();

      // Check image size before encoding
      if (imageData.lengthInBytes > 750 * 1024) {
        // Resize the image if it's too large
        print('Image size too large. Compressing...');
        img.Image? decodedImage = img.decodeImage(imageData);
        if (decodedImage != null) {
          img.Image resizedImage =
              img.copyResize(decodedImage, width: 800); // Resize to max width
          imageData =
              Uint8List.fromList(img.encodeJpg(resizedImage, quality: 85));
          print('Image compressed to ${imageData.lengthInBytes / 1024} KB');
        } else {
          throw Exception('Error decoding image for resizing.');
        }
      }

      // Update the UI with the resized image
      updateImageCallback(imageData);

      // Encode to Base64
      String base64Image = base64Encode(imageData);
      print('Encoded Base64 image size: ${base64Image.length} bytes');

      // Save to Firestore
      await saveImageToFirestore(base64Image);
    }
  } catch (e) {
    context.showSnack(message: 'Error picking or saving image: $e');
  }
}

Future<void> saveImageToFirestore(String base64Image) async {
  try {
    // Ensure the Base64 string is not null or empty
    if (base64Image.isEmpty) {
      throw Exception('Base64 image string is empty.');
    }

    // Get the current user's email
    String userEmail = FirebaseAuth.instance.currentUser!.email!;
    print('User Email: $userEmail');

    // Query Firestore for the user document
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .get();

    DocumentReference userDoc;
    if (querySnapshot.docs.isEmpty) {
      // Document does not exist; create a new one
      print('Document not found. Creating a new document...');
      userDoc = FirebaseFirestore.instance.collection('users').doc(userEmail);
      await userDoc.set({
        'profile_image': base64Image, // Save Base64 string
        'email': userEmail,
        'username': FirebaseAuth.instance.currentUser?.displayName ?? 'Unknown',
        'gender': 'Not specified', // Provide default value
      });
    } else {
      // Document exists; update the profile image
      print('Document found. Updating image...');
      userDoc = querySnapshot.docs.first.reference;
      await userDoc.update({
        'profile_image': base64Image,
      });
    }

    print('Image saved successfully to Firestore!');
  } catch (e) {
    // Log specific details of the error
    print('Error saving image to Firestore: $e');
    throw Exception('Error saving image to Firestore: $e');
  }
}
