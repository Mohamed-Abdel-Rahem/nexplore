import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  const MyTextBox({
    Key? key,
    required this.text,
    required this.sectionName,
    this.onPressed,
    this.Tooltiptext,
  }) : super(key: key);

  final String text;
  final String? Tooltiptext;
  final String sectionName;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 10,
      ),
      child: Material(
        elevation: 2,
        shadowColor: const Color(0xff94A3B8),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 137, 152, 179),
              width: 3,
            ),
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.only(left: 15, bottom: 15),
          margin: const EdgeInsets.only(bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    sectionName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Lexend Deca',
                      color: Color(0xff6A8DC1),
                    ),
                  ),
                  if (onPressed != null)
                    Tooltip(
                      message: Tooltiptext, // Tooltip message
                      textStyle: const TextStyle(
                        color: Colors.white, // Text color
                        fontSize: 16, // Font size
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(
                            221, 90, 89, 89), // Background color
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                      ),
                      child: IconButton(
                        onPressed: onPressed,
                        icon: const Icon(
                          Icons.settings,
                          color: Color(0xff6A8DC1),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 85, 106, 138),
                  fontFamily: 'Lexend Deca',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
