import 'package:chad_chat/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.label, this.onChanged});
  final String label;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      style: const TextStyle(color: mainText),
      decoration: InputDecoration(
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
