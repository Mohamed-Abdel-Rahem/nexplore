import 'package:flutter/material.dart';
import 'package:nexplore/constants/constant.dart';
import 'package:nexplore/screen/loginScreeen.dart';
import 'package:nexplore/widgets/customButton.dart';
import 'package:nexplore/widgets/customTextButton.dart';
import 'package:nexplore/widgets/customTextForm.dart';
import 'package:nexplore/widgets/cutomText.dart';

class SignUpScreeen extends StatefulWidget {
  const SignUpScreeen({super.key});
  static String id = 'SignUpScreeen';

  @override
  State<SignUpScreeen> createState() => _SignUpScreeenState();
}

class _SignUpScreeenState extends State<SignUpScreeen> {
  bool isChecked = false;

  Widget build(BuildContext context) {
    final double avatarRadius = ScreenUtils.avatarRadius(context);
    final double screenHeight = ScreenUtils.screenHeight(context);
    final double screenWidth = ScreenUtils.screenWidth(context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                radius: avatarRadius,
                backgroundColor: Colors.white,
                backgroundImage: const AssetImage(
                  'assets/images/remplayicon.png',
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              CustomText(
                text: 'Join Nexplore',
                color: const Color.fromARGB(255, 54, 88, 155),
                fontSize: screenWidth * 0.08, // 8% of screen width
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ), // 1% of screen height
              CustomText(
                text: 'Create an account to get personalized ',
                color: const Color(0xff6A8DC1),
                fontSize: screenWidth * 0.04, // 4% of screen width
              ),
              CustomText(
                text: 'recommendations',
                color: const Color(0xff6A8DC1),
                fontSize: screenWidth * 0.04, // 4% of screen width
              ),
              SizedBox(
                height: screenHeight * 0.03,
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
              CustomTextForm(
                dataLabelText: 'Email',
                dataHintText: 'Enter your email',
                isPassword: false,
                prefixIcon: Image.asset(
                  width: screenWidth * 0.06, // 6% of screen width
                  height: screenWidth * 0.06,
                  'assets/icons/email.png',
                ),
              ),
              CustomTextForm(
                dataLabelText: 'Password',
                dataHintText: 'Enter your Password',
                isPassword: true,
                prefixIcon: Image.asset(
                  'assets/icons/lock.png',
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: isChecked,
                    activeColor: Colors.blue,
                    onChanged: (newBool) {
                      setState(() {
                        isChecked = newBool!;
                      });
                    },
                  ),
                  CustomText(
                    color: Color(0xff6A8DC1),
                    text: 'I agree to the Terms & Conditions ',
                    fontSize: 16,
                  ),
                ],
              ),
              CustomButton(
                onPressed: () {},
                color: const Color(0xff3A5A98),
                txt: 'Sign Up',
                vs: screenHeight * 0.013, // Button vertical padding
                hs: screenWidth * 0.3, // Button horizontal padding
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                      text: 'Already have an account?',
                      color: const Color.fromARGB(255, 61, 63, 204),
                      fontSize: 16),
                  CustomTextButton(
                    text: 'Log In',
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, LoginScreeen.id);
                    },
                  ), // 3% of screen height// 2% of screen height
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
