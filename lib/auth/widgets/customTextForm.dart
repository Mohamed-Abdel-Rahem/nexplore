import 'package:flutter/material.dart';

class CustomTextForm extends StatefulWidget {
  CustomTextForm({
    Key? key,
    required this.dataLabelText,
    required this.dataHintText,
    this.data, // Optional controller
    this.onChanged,
    this.validator, // Validator function
    this.isPassword = false,
    required this.prefixIcon,
  }) : super(key: key);

  final TextEditingController? data; // Optional controller
  final String dataLabelText;
  final String dataHintText;
  final Widget prefixIcon;
  final bool isPassword;
  final Function(String)? onChanged;
  final String? Function(String?)? validator; // Nullable validator

  @override
  State<CustomTextForm> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  TextEditingController? _internalController;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    // Use the provided controller or create an internal one
    _internalController = widget.data ?? TextEditingController();
  }

  @override
  void dispose() {
    // Dispose only if we created the controller internally
    if (widget.data == null) {
      _internalController?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Material(
        elevation: 2,
        shadowColor: const Color(0xff94A3B8),
        child: TextFormField(
          controller: _internalController,
          validator: widget.validator, // Use the provided validator
          onChanged: (value) {
            widget.onChanged?.call(value); // Call onChanged if provided
          },
          obscureText: widget.isPassword ? _obscureText : false,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Lexend Deca',
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xffF0F7FF),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            labelText: widget.dataLabelText,
            hintText: widget.dataHintText,
            hintStyle: const TextStyle(
              color: Color(0xff94A3B8),
              fontFamily: 'Lexend Deca',
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.blue,
                width: 3,
              ), // Change border color when focused
              borderRadius: BorderRadius.circular(8),
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isPassword
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                  )
                : null,
            labelStyle: const TextStyle(
              color: Color.fromARGB(255, 97, 106, 117),
              fontSize: 20,
              fontFamily: 'Lexend Deca',
            ),
          ),
        ),
      ),
    );
  }
}
