import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:nexplore/screen/settingPage.dart';
import 'package:nexplore/services/pickImage.dart';
import 'package:nexplore/widgets/customButton.dart';
import 'package:nexplore/widgets/customTextBox.dart';
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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: screenWidth * .02),
            child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, SettingPage.id);
                },
                icon: const Icon(Icons.settings),
                color: const Color(0xff6A8DC1)),
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
              height: screenHeight * .02,
            ),
            MyTextBox(
              text: 'Ahmed Mohamed',
              sectionName: 'Full Name : ',
              onPressed: () {},
              Tooltiptext: 'Edite youre name',
            ),
            MyTextBox(
              text: 'mohamed28101999@gmail.com',
              sectionName: 'Email : ',
              Tooltiptext: 'Edite youre name',
            ),
            const MyTextBox(
              text: 'Male',
              sectionName: 'Gender : ',
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
