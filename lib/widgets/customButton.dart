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
  final double vs;
  final double hs;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        txt,
        style: TextStyle(
          fontSize: 24,
          color: txtcolor ?? Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'Lexend Deca',
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff1A73E8),
        padding: EdgeInsets.symmetric(
          vertical: vs,
          horizontal: hs,
        ),
      ),
    );
  }
}
