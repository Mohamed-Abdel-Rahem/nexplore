import 'package:flutter/material.dart';
import 'package:nexplore/constants/constant.dart';
import 'package:nexplore/screen/accountInfo.dart';
import 'package:nexplore/screen/signupScreen.dart';
import 'package:nexplore/widgets/customButton.dart';
import 'package:nexplore/widgets/customTextButton.dart';
import 'package:nexplore/widgets/customTextForm.dart';
import 'package:nexplore/widgets/cutomText.dart';

class LoginScreeen extends StatefulWidget {
  const LoginScreeen({super.key});
  static String id = 'LoginScreeen';
  @override
  State<LoginScreeen> createState() => _LoginScreeenState();
}

class _LoginScreeenState extends State<LoginScreeen> {
  @override
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
              ), // 2% of screen height
              CustomText(
                text: 'Welcome Back',
                color: const Color(0xff1A73E8),
                fontSize: screenWidth * 0.08, // 8% of screen width
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ), // 1% of screen height
              CustomText(
                text: 'Sign in to continue exploring.',
                color: const Color(0xff6A8DC1),
                fontSize: screenWidth * 0.04, // 4% of screen width
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ), // 3% of screen height
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
              CustomTextButton(
                onPressed: () {},
                text: 'Forget Password ?',
              ),
              CustomButton(
                onPressed: () {
                  Navigator.pushNamed(context, AccountInformation.id);
                },
                color: const Color(0xff1A73E8),
                txt: 'Login',
                vs: screenHeight * 0.013, // Button vertical padding
                hs: screenWidth * 0.3, // Button horizontal padding
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    color: const Color.fromARGB(255, 61, 63, 204),
                    text: 'Do not have an account ?',
                    fontSize: screenWidth * 0.045, // 4.5% of screen width
                  ),
                  CustomTextButton(
                    text: 'SignUp',
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, SignUpScreeen.id);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
