import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({super.key});
  static String id = 'AccountInformation';

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  Uint8List? _image; // To store the selected image

  // Function to pick an image and handle permission
  Future<void> _pickImage() async {
    PermissionStatus status = await Permission.photos.status;

    if (status.isGranted) {
      // If permission is already granted
      _getFromGallery();
    } else if (status.isDenied || status.isRestricted) {
      // If permission is denied or restricted, request it
      PermissionStatus newStatus = await Permission.photos.request();
      if (newStatus.isGranted) {
        _getFromGallery(); // Retry opening gallery
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
      _showPermissionDialog();
    }
  }

  // Function to pick an image from the gallery
  Future<void> _getFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final Uint8List imageData = await pickedFile.readAsBytes();
        setState(() {
          _image = imageData;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  // Function to show a permission dialog
  void _showPermissionDialog() {
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

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Information'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: screenWidth * 0.2,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: _image != null
                      ? MemoryImage(_image!)
                      : const AssetImage('assets/images/profile.png')
                          as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: _pickImage,
                    icon: const Icon(
                      Icons.add_a_photo,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_image != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Image saved successfully!')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please select an image first.')),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
