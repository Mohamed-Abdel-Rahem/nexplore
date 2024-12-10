import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nexplore/auth/screen/loginScreeen.dart';
import 'package:nexplore/auth/widgets/customButton.dart';
import 'package:nexplore/auth/widgets/customTextForm.dart';
import 'package:nexplore/auth/widgets/cutomText.dart';
import 'package:nexplore/core/routes/routres.dart';
import 'package:nexplore/util/extensions/context_extension.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});
  static String id = 'Settinpage';

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController currentPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  String? passwordMismatchError;
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
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
                      backgroundColor: const Color.fromARGB(255, 144, 157, 184),
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
              data: currentPassword,
            ),
            CustomTextForm(
              dataLabelText: 'New Password',
              dataHintText: 'Enter your password',
              isPassword: true,
              prefixIcon: Image.asset(
                'assets/icons/lock.png',
              ),
              data: newPassword,
            ),
            CustomTextForm(
              dataLabelText: 'Confirm New Password',
              dataHintText: 'Enter your password',
              isPassword: true,
              data: confirmPassword,
              prefixIcon: Image.asset(
                'assets/icons/lock.png',
              ),
            ),
            if (passwordMismatchError != null)
              Text(
                passwordMismatchError!,
                style: const TextStyle(color: Colors.red),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: CustomButton(
                onPressed: _changePassword,
                color: const Color(0xff3A5A98),
                txt: 'Update Password',
                vs: screenHeight * 0.02, // Button vertical padding
                hs: screenWidth * 0.24,
              ),
            ) // Button horizontal padding onPressed: onPressed)
          ],
        ),
      ),
    );
  }

  Future<void> _signOutAndNavigateToLoginPage() async {
    try {
      await _auth.signOut();
      context.navigateRep(Routes.login);
    } catch (e) {
      // Handle sign out error, if any
    }
  }

  Future<void> _changePassword() async {
    if (newPassword.text != confirmPassword.text) {
      setState(() {
        passwordMismatchError = "New Passwords don't match";
      });
    } else {
      try {
        final currentUser = _auth.currentUser;
        if (currentUser != null) {
          // Reauthenticate user
          final credential = EmailAuthProvider.credential(
            email: currentUser.email!,
            password: currentPassword.text,
          );
          await currentUser.reauthenticateWithCredential(credential);

          // Change password
          await currentUser.updatePassword(newPassword.text);

          // Clear text fields and error message
          currentPassword.text = '';
          newPassword.text = '';
          confirmPassword.text = '';
          setState(() {
            passwordMismatchError = null;
          });

          // Sign out and navigate to login page
          _signOutAndNavigateToLoginPage();
        }
      } catch (e) {
        // Handle errors such as wrong current password or network issues
        setState(() {
          passwordMismatchError = 'Error changing password';
        });
      }
    }
  }
}
