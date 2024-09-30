import 'package:chad_chat/components/custom_button.dart';
import 'package:chad_chat/components/custom_text_Field.dart';
import 'package:chad_chat/views/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:chad_chat/constants/colors.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static String id = 'LoginView';
  @override
  Widget build(BuildContext context) {
    // Get the device's width and height using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: mainColor,
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
                  color: mainText,
                ),
              ),
              SizedBox(
                  height: screenHeight *
                      0.05), // Space between title and email field
              const CustomTextField(label: 'Enter Your Email'),
              SizedBox(
                  height:
                      screenHeight * 0.03), // Space between email and password
              const CustomTextField(label: 'Enter Your Password'),
              SizedBox(
                  height: screenHeight * 0.04), // Space before sign-in button
              const CustomButton(label: 'Sign In'),
              SizedBox(
                  height: screenHeight *
                      0.03), // Space before the "Don't have an account?" text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account? ',
                    style: TextStyle(
                      color: mainText,
                      fontSize: screenWidth * 0.045, // Dynamic font size
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignUpView.id);
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: yellow,
                        fontSize: screenWidth * 0.045, // Dynamic font size
                      ),
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
}
