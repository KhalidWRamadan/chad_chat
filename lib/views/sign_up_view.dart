import 'dart:developer';

import 'package:chad_chat/components/custom_button.dart';
import 'package:chad_chat/components/custom_text_field.dart';
import 'package:chad_chat/constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});
  static String id = 'SignUpView';
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    String? email;
    String? password;
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
              CustomTextField(
                label: 'Enter Your Email',
                onChanged: (data) {
                  email = data;
                },
              ),
              SizedBox(
                  height:
                      screenHeight * 0.03), // Space between email and password
              CustomTextField(
                label: 'Enter Your Password',
                onChanged: (data) {
                  password = data;
                },
              ),
              SizedBox(
                  height:
                      screenHeight * 0.03), // Space between email and password
              const CustomTextField(
                label: 'Confirm Your Password',
              ),

              SizedBox(
                  height: screenHeight * 0.04), // Space before sign-in button
              CustomButton(
                label: 'Sign Up',
                onPressed: () async {
                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email!,
                      password: password!,
                    );
                    log(credential.user?.email ?? 'Nothing');
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      log('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      log('The account already exists for that email.');
                    }
                  } catch (e) {
                    log(e.toString());
                  }
                },
              ),
              SizedBox(
                  height: screenHeight *
                      0.03), // Space before the "Don't have an account?" text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(
                      color: mainText,
                      fontSize: screenWidth * 0.045, // Dynamic font size
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Login',
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
