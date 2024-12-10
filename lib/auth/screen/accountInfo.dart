import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nexplore/auth/firebase/models/getDataFirebase.dart';
import 'package:nexplore/auth/screen/loginScreeen.dart';
import 'package:nexplore/auth/screen/settingPage.dart';
import 'package:nexplore/auth/services/pickImage.dart';
import 'package:nexplore/auth/utils/extension/contextExtension.dart';
import 'package:nexplore/auth/widgets/customButton.dart';
import 'package:nexplore/auth/widgets/customTextBox.dart';
import 'package:nexplore/auth/widgets/cutomText.dart';
import 'package:nexplore/core/routes/routres.dart';
import 'package:nexplore/util/extensions/context_extension.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({super.key});
  static String id = 'AccountInformation';

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  Uint8List? _image; // To store the selected image
  FirebaseGetData? userData; // To store user data
  bool isLoading = true; // Loading state for fetching data
  bool isUploading = false; // Track if the image is being uploaded
  late TextEditingController _usernameController;

  // Initialize PullToRefreshController
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _fetchUserData();
  }

  // Function to fetch user data from Firestore
  void _fetchUserData() async {
    try {
      String userEmail = FirebaseAuth.instance.currentUser!.email!;

      // Fetch user data from Firestore
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userEmail) // Use email as document ID
          .get();

      if (userDoc.exists) {
        String? base64Image = userDoc.get('profile_image');
        String? username = userDoc.get('username');
        String? email = userDoc.get('email');
        String? gender = userDoc.get('gender');

        setState(() {
          userData = FirebaseGetData(
            name: username ?? 'N/A',
            email: email ?? 'N/A',
            gender: gender ?? 'N/A',
          );

          // Decode image if available
          if (base64Image != null && base64Image.isNotEmpty) {
            _image = base64Decode(base64Image);
          }

          isLoading = false;
        });
      } else {
        context.showSnack(message: 'User data not found.');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      context.showSnack(message: 'Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  // Function to update user image
  void _updateImage(Uint8List imageData) {
    setState(() {
      isUploading = true;
      _image = imageData;
    });

    String base64Image = base64Encode(imageData);

    // Simulate saving image to Firestore
    saveImageToFirestore(base64Image).then((_) {
      setState(() {
        isUploading = false;
      });
      context.showSnack(message: 'Image updated successfully!');
    }).catchError((e) {
      setState(() {
        isUploading = false;
      });
      context.showSnack(message: 'Failed to update image: $e');
    });
  }

  // Function to update username
  Future<void> _updateUsername() async {
    String newUsername = _usernameController.text.trim();
    if (newUsername.isNotEmpty) {
      try {
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser.email) // Use email as document ID
              .update({'username': newUsername});
          context.showSnack(
              message:
                  'Username updated successfully reload the page to show that');
        } else {
          throw Exception('User is not logged in');
        }
      } catch (e) {
        context.showSnack(message: 'Failed to update username');
      }
    } else {
      context.showSnack(message: 'Username cannot be empty');
    }
  }

  // Refresh function to reload user data
  void _onRefresh() async {
    _fetchUserData(); // Re-fetch user data
    refreshController.refreshCompleted(); // Stop the refresh indicator
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: screenWidth * .02),
            child: IconButton(
              onPressed: () {
                context.navigateTo(Routes.Settinpage);
              },
              icon: const Icon(Icons.settings),
              color: const Color(0xff6A8DC1),
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xff6A8DC1),
          ),
        ),
        backgroundColor: Colors.white,
        title: CustomText(
          text: 'Account Information',
          color: const Color(0xff6A8DC1),
          fontSize: screenWidth * 0.04,
        ),
        centerTitle: true,
      ),
      body: SmartRefresher(
        controller: refreshController,
        onRefresh: _onRefresh, // Trigger refresh when pulled
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.02),
                      child: CircleAvatar(
                        radius: screenWidth * 0.2,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: _image != null
                            ? MemoryImage(_image!)
                            : const AssetImage('assets/images/profile.png')
                                as ImageProvider,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: isUploading
                          ? const CircularProgressIndicator()
                          : IconButton(
                              onPressed: () {
                                pickImageAndSave(context, _updateImage);
                              },
                              icon: const Icon(
                                Icons.add_a_photo,
                                color: Colors.blue,
                                size: 30,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Full Name:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        hintText: 'Enter new your username',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              // Add MyTextBox for username here
              MyTextBox(
                text: userData?.name ?? 'N/A',
                sectionName: 'Full Name :',
              ),
              MyTextBox(
                text: userData?.email ?? 'N/A',
                sectionName: 'Email :',
                Tooltiptext: 'Edit your email',
              ),
              MyTextBox(
                text: userData?.gender ?? 'N/A',
                sectionName: 'Gender :',
                Tooltiptext: 'Edit your gender',
              ),
              CustomButton(
                txt: 'Save Changes',
                color: const Color(0xff4b39ef),
                vs: screenHeight * 0.013,
                hs: screenWidth * 0.3,
                onPressed: () {
                  // Update username when the button is pressed
                  _updateUsername();
                },
              ),
              SizedBox(height: screenHeight * 0.02),

              CustomButton(
                txt: 'Delete Account',
                color: const Color.fromARGB(255, 216, 56, 27),
                vs: screenHeight * 0.013,
                hs: screenWidth * 0.2,
                onPressed: () {
                  // Delete the account
                  _deleteAccount();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _deleteAccount() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        // Show confirmation dialog
        bool confirm = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Account'),
            content:
                const Text('Are you sure you want to delete your account?'),
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
          ),
        );

        if (confirm == true) {
          // Delete user from Firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser.email) // Use email as document ID
              .delete();

          // Delete user from Firebase Authentication
          await currentUser.delete();

          // Navigate back to login page
          context.navigateRep(Routes.login);
        }
      } else {
        throw Exception('User is not logged in');
      }
    } catch (e) {
      // Handle errors here

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content:
                const Text('Failed to delete account. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
