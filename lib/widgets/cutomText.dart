import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget CutomText(
    {required final String text,
    required final Color color,
    required final double fontSize}) {
  return Text(
    text,
    style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: 'Lexend Deca',
        fontWeight: FontWeight.bold),
  );
}
