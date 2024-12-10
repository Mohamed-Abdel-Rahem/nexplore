// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.txt,
    required this.color,
    required this.vs,
    required this.hs,
    required this.onPressed,
    this.txtcolor,
  }) : super(key: key);

  final String txt;
  final Color color;
  final Color? txtcolor;
  final double vs; // Base vertical padding
  final double hs; // Base horizontal padding
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;

    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        txt,
        style: TextStyle(
          fontSize: screenWidth * 0.05, // Font size is 5% of screen width
          color: txtcolor ?? Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'Lexend Deca',
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(8), // Border radius is 2% of screen width
        ),
        backgroundColor: color,
        padding: EdgeInsets.symmetric(
          vertical: vs, // Scale vertical padding
          horizontal: hs, // Scale horizontal padding
        ),
      ),
    );
  }
}
