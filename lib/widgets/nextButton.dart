import 'package:flutter/material.dart';

Widget NextButton({
  required final VoidCallback onPressed,
  required BuildContext context,
}) {
  // Get the screen width and height
  final double screenWidth = MediaQuery.of(context).size.width;

  // Calculate the button's size proportionally to the screen dimensions
  final double buttonSize = screenWidth * 0.18; // 18% of the screen width
  final double iconSize = buttonSize * 0.5; // 50% of the button size

  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white, // Circle button background color
        border: Border.all(
          color: const Color(0xff7374FF), // Border color
          width: buttonSize * 0.04, // 4% of button size as border width
        ),
      ),
      child: Icon(
        Icons.arrow_forward,
        size: iconSize, // Adjust icon size proportionally
        color: const Color(0xff7374FF),
      ),
    ),
  );
}
