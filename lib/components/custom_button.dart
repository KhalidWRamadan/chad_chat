// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:chad_chat/constants/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.label, this.onPressed});
  final String label;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const LinearBorder(),
          minimumSize: Size(double.infinity,
              screenHeight * 0.06), // Full width, dynamic height
        ),
        child: Text(
          label,
          style: TextStyle(
            color: yellow,
            fontSize: screenWidth * 0.05, // Dynamic font size
          ),
        ),
      ),
    );
  }
}
