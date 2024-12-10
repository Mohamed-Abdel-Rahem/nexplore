import 'package:flutter/material.dart';
import 'package:nexplore/auth/constants/constant.dart';
import 'package:nexplore/auth/screen/loginScreeen.dart';
import 'package:nexplore/auth/widgets/customTextOnboarding.dart';

Widget SkipButton(BuildContext context) {
  final double screenWidth = ScreenUtils.screenWidth(context);

  return MaterialButton(
    onPressed: () {
      Navigator.pushReplacementNamed(context, LoginScreeen.id);
    },
    child: CustomTextOnBoarding(
      color: Colors.white,
      text: 'Skip',
      fontSize: screenWidth * 0.04,
    ),
  );
}
