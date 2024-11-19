import 'package:flutter/material.dart';
import 'package:nexplore/widgets/cutomText.dart';

Widget CustomAlignment({
  required final String text,
  required final double fontSize,
}) {
  return Align(
    alignment: Alignment.topLeft,
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
      ),
      child: CustomText(
        text: text,
        color: const Color.fromARGB(255, 95, 103, 117),
        fontSize: fontSize,
      ),
    ),
  );
}
