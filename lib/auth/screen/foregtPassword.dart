import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nexplore/auth/constants/constant.dart';
import 'package:nexplore/auth/screen/loginScreeen.dart';
import 'package:nexplore/auth/widgets/customButton.dart';
import 'package:nexplore/auth/widgets/customTextButton.dart';
import 'package:nexplore/auth/widgets/customTextForm.dart';
import 'package:nexplore/auth/widgets/cutomText.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});
  static String id = 'ForgetPasswordScreen';
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  String? email, password;
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> passwordReset() async {
    try {
      final String email = _emailController.text.trim();

      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Show success dialog if the password reset email is sent successfully
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Success'),
            content: Text('Password reset email sent to $email'),
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
    } on FirebaseAuthException catch (e) {
      // Show error dialog if an error occurs during password reset
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(e.message.toString()),
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

  @override
  Widget build(BuildContext context) {
    final double screenHeight = ScreenUtils.screenHeight(context);
    final double screenWidth = ScreenUtils.screenWidth(context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: 'Forget Password?',
                color: Colors.black,
                fontSize: screenWidth * 0.07,
              ),
              SizedBox(
                height: screenHeight * .02,
              ),
              CustomText(
                text: 'No Worries we will send you reset instructions',
                color: const Color(0Xff9FA0A3),
                fontSize: screenWidth * 0.039,
              ),
              SizedBox(
                height: screenHeight * .02,
              ),
              CustomTextForm(
                data: _emailController,
                dataLabelText: 'Email',
                dataHintText: 'Enter your email',
                isPassword: false,
                prefixIcon: Image.asset(
                  width: screenWidth * 0.06, // 6% of screen width
                  height: screenWidth * 0.06,
                  'assets/icons/email.png',
                ),
                onChanged: (value) => email = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  final emailRegex =
                      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Enter a valid email address';
                  }
                  return null; // No error
                },
              ),
              SizedBox(
                height: screenHeight * .02,
              ),
              CustomButton(
                onPressed: passwordReset,
                color: const Color(0xff1A73E8),
                txt: 'Reset Password',
                vs: screenHeight * 0.013, // Button vertical padding
                hs: screenWidth * 0.26, // Button horizontal padding
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, LoginScreeen.id);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: const Color(0Xff9FA0A3),
                      size: screenWidth * 0.06,
                    ),
                  ),
                  CustomTextButton(
                    text: 'Back to log in',
                    color: const Color(0Xff9FA0A3),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, LoginScreeen.id);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
