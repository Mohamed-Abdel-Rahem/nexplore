import 'package:flutter/material.dart';

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

class ScreenUtils {
  // Get screen width
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  // Get screen height
  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // Calculate proportional spacing
  static double proportionalWidth(BuildContext context, double percentage) {
    return screenWidth(context) * percentage;
  }

  static double proportionalHeight(BuildContext context, double percentage) {
    return screenHeight(context) * percentage;
  }

  // Get padding (example: 5% of screen width)
  static double padding(BuildContext context) {
    return screenWidth(context) * 0.05;
  }

  // Get avatar radius (example: 20% of screen width)
  static double avatarRadius(BuildContext context) {
    return screenWidth(context) * 0.2;
  }
}
