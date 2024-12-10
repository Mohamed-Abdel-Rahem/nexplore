import 'package:flutter/material.dart';

Widget CustomTextOnBoarding(
    {required String text, required Color color, required double fontSize}) {
  return Text(
    textAlign: TextAlign.center,
    text,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: 'Lexend Deca',
    ),
  );
}
