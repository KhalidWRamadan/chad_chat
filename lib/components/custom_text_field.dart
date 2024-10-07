import 'package:flutter/material.dart';

import 'package:chad_chat/constants/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key, required this.label, this.onChanged, this.validator});
  final String label;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onChanged: onChanged,
      style: const TextStyle(color: mainText),
      decoration: InputDecoration(
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: yellow),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: yellow),
        ),
        errorStyle: const TextStyle(color: yellow),
        label: Text(label),
        labelStyle: const TextStyle(color: mainText),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: yellow),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: yellow),
        ),
      ),
    );
  }
}
