import 'package:flutter/material.dart';
import 'package:chad_chat/constants/colors.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the device's width and height using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.08, // Dynamic horizontal padding
            vertical: screenHeight * 0.05, // Dynamic vertical padding
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.05), // Top spacing
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/giga.jpg',
                  width:
                      screenWidth * 0.25, // Dynamic width (25% of screen width)
                  height: screenHeight * 0.15, // Dynamic height
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                  height: screenHeight * 0.05), // Space between image and text
              Text(
                'Chad Chat',
                style: TextStyle(
                  fontFamily: 'PlayfairDisplay',
                  fontStyle: FontStyle.italic,
                  fontSize:
                      screenWidth * 0.08, // Font size relative to screen width
                  color: AppColors.mainText,
                ),
              ),
              SizedBox(
                  height: screenHeight *
                      0.05), // Space between title and email field
              customTextField('Enter Your Email'),
              SizedBox(
                  height:
                      screenHeight * 0.03), // Space between email and password
              customTextField('Enter Your Password'),
              SizedBox(
                  height: screenHeight * 0.04), // Space before sign-in button
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: const LinearBorder(),
                    minimumSize: Size(double.infinity,
                        screenHeight * 0.06), // Full width, dynamic height
                  ),
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      color: AppColors.subColor,
                      fontSize: screenWidth * 0.05, // Dynamic font size
                    ),
                  ),
                ),
              ),
              SizedBox(
                  height: screenHeight *
                      0.03), // Space before the "Don't have an account?" text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account? ',
                    style: TextStyle(
                      color: AppColors.mainText,
                      fontSize: screenWidth * 0.045, // Dynamic font size
                    ),
                  ),
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      color: AppColors.yellow,
                      fontSize: screenWidth * 0.045, // Dynamic font size
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.08), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }

  TextField customTextField(String label) {
    return TextField(
      style: const TextStyle(color: AppColors.mainText),
      decoration: InputDecoration(
        label: Text(label),
        labelStyle: const TextStyle(color: AppColors.mainText),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.yellow),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.yellow),
        ),
      ),
    );
  }
}
