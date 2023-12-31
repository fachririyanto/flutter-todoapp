import 'package:flutter/material.dart';

class Textbox extends StatelessWidget {
  final TextEditingController controller;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final String? hintText;
  final bool obscureText;

  const Textbox({
    super.key,
    required this.controller,
    this.onChanged,
    this.validator,
    this.hintText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFF2F2F2),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xFFABABAB),
        ),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
