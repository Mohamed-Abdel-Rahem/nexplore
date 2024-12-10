import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget CustomTextButton({
  required final String text,
  required final VoidCallback? onPressed,
  Color? color,
}) {
  return TextButton(
    onPressed: onPressed,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 19,
        color: color ?? Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
