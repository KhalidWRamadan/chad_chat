import 'package:chad_chat/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: const LinearBorder(),
          minimumSize: Size(double.infinity,
              screenHeight * 0.06), // Full width, dynamic height
        ),
        child: Text(
          label,
          style: TextStyle(
            color: AppColors.subColor,
            fontSize: screenWidth * 0.05, // Dynamic font size
          ),
        ),
      ),
    );
  }
}
