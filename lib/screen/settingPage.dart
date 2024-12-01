import 'package:flutter/material.dart';
import 'package:nexplore/widgets/customButton.dart';
import 'package:nexplore/widgets/customTextForm.dart';
import 'package:nexplore/widgets/cutomText.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});
  static String id = 'Settinpage';

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String? currentPassword, newPassword, confirmNewPassword;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.06,
                    right: screenWidth * 0.1,
                    top: screenWidth * 0.2,
                    bottom: screenWidth * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: CircleAvatar(
                        backgroundColor:
                            const Color.fromARGB(255, 144, 157, 184),
                        radius: screenWidth * 0.07,
                        child: Padding(
                          padding: EdgeInsets.only(left: screenWidth * .02),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              size: screenWidth * 0.07,
                            ),
                            color: const Color.fromARGB(255, 85, 84, 84),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    CustomText(
                      text: 'Set a new password',
                      color: const Color.fromARGB(255, 54, 88, 155),
                      fontSize: screenWidth * 0.06, // 8% of screen width
                    ),
                    SizedBox(
                      height: screenHeight * 0.008,
                    ),
                    CustomText(
                      text:
                          'Create a new password. Ensure it differs from previous ones for security',
                      color: const Color(0xff6A8DC1),
                      fontSize: screenWidth * 0.04, // 4% of screen width
                    ),
                  ],
                ),
              ),
              CustomTextForm(
                dataLabelText: 'Current Password',
                dataHintText: 'Enter your password',
                isPassword: true,
                prefixIcon: Image.asset(
                  'assets/icons/lock.png',
                ),
                onChanged: (value) => currentPassword = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                },
              ),
              CustomTextForm(
                dataLabelText: 'New Password',
                dataHintText: 'Enter your password',
                isPassword: true,
                prefixIcon: Image.asset(
                  'assets/icons/lock.png',
                ),
                onChanged: (value) => newPassword = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                },
              ),
              CustomTextForm(
                dataLabelText: 'Confirm New Password',
                dataHintText: 'Enter your password',
                isPassword: true,
                prefixIcon: Image.asset(
                  'assets/icons/lock.png',
                ),
                onChanged: (value) => confirmNewPassword = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  if (newPassword != confirmNewPassword) {
                    return 'Password must be matched';
                  }
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                child: CustomButton(
                  onPressed: () {},
                  color: const Color(0xff3A5A98),
                  txt: 'Update Password',
                  vs: screenHeight * 0.02, // Button vertical padding
                  hs: screenWidth * 0.24,
                ),
              ) // Button horizontal padding onPressed: onPressed)
            ],
          ),
        ),
      ),
    );
  }
}
