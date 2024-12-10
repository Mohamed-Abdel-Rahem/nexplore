import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<Uint8List?> getImageFromFirestore(String uid) async {
  try {
    // Retrieve the Base64 image string from Firestore
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (userDoc.exists) {
      // Get the Base64 string of the image
      String base64Image = userDoc['profile_image'] ?? '';

      if (base64Image.isNotEmpty) {
        // Convert Base64 string back to Uint8List
        Uint8List imageBytes = base64Decode(base64Image);
        return imageBytes;
      }
    }
    return null;
  } catch (e) {
    throw Exception('Error fetching image from Firestore: $e');
  }
}
