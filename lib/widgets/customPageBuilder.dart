import 'package:flutter/material.dart';

Widget CustomPageBuilder({required String imagePath}) {
  return Container(
    height: 300,
    width: 306,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15), // Optional rounded corners
      image: DecorationImage(
        image: AssetImage(
          imagePath, // Replace with your image URL
        ),
      ),
    ),
  );
}
