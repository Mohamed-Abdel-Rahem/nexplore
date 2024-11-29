import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:nexplore/services/pickImage.dart';
import 'package:nexplore/widgets/customButton.dart';
import 'package:nexplore/widgets/customTextForm.dart';
import 'package:nexplore/widgets/cutomText.dart';
import 'package:nexplore/widgets/defineAlignment.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({super.key});
  static String id = 'AccountInformation';

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  Uint8List? _image; // To store the selected image

  // Callback to update the image
  void _updateImage(Uint8List imageData) {
    setState(() {
      _image = imageData; // Update the image state
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
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
          fontSize: screenWidth * 0.06,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                    child: IconButton(
                      onPressed: () {
                        pickImage(context, _updateImage); // Pass the callback
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
            SizedBox(
              height: screenHeight * 0.01,
            ),
            CustomText(
              text: 'mohamed28101999@gmail.com',
              color: const Color(0xff6A8DC1),
              fontSize: screenWidth * 0.05, // 8% of screen width
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            CustomAlignment(
              text: 'Full Name : ',
              fontSize: screenWidth * 0.05,
            ),
            CustomTextForm(
              dataLabelText: 'Name',
              dataHintText: 'Enter your Name',
              isPassword: false,
              prefixIcon: Image.asset(
                width: screenWidth * 0.06, // 6% of screen width
                height: screenWidth * 0.06,
                'assets/icons/user.png',
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            CustomAlignment(
              text: 'My Phone : ',
              fontSize: screenWidth * 0.05,
            ),
            CustomTextForm(
              dataLabelText: 'Phone Number',
              dataHintText: 'Enter your number',
              isPassword: false,
              prefixIcon: Icon(
                Icons.phone,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            CustomAlignment(
              text: 'My Password : ',
              fontSize: screenWidth * 0.05,
            ),
            CustomTextForm(
              dataLabelText: 'Password',
              dataHintText: 'Enter your Password',
              isPassword: true,
              prefixIcon: Image.asset(
                'assets/icons/lock.png',
              ),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            CustomButton(
                txt: 'Save Changes',
                color: const Color(0xff4b39ef),
                vs: screenHeight * 0.013, // Button vertical padding
                hs: screenWidth * 0.3,
                onPressed: () {
                  if (_image != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Data change saved successfully!',
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Please Change any data to save',
                        ),
                      ),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
