import 'package:chad_chat/components/custom_button.dart';
import 'package:chad_chat/components/custom_snack_bar.dart';
import 'package:chad_chat/components/custom_text_Field.dart';
import 'package:chad_chat/views/home_view.dart';
import 'package:chad_chat/views/sign_up_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chad_chat/constants/colors.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static String id = 'LoginView';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> formKey = GlobalKey();
  String? email;
  String? password;
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
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.05), // Top spacing
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/giga.jpg',
                    width: screenWidth *
                        0.25, // Dynamic width (25% of screen width)
                    height: screenHeight * 0.15, // Dynamic height
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                    height:
                        screenHeight * 0.05), // Space between image and text
                Text(
                  'Chad Chat',
                  style: TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontStyle: FontStyle.italic,
                    fontSize: screenWidth *
                        0.08, // Font size relative to screen width
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
                  validator: (data) {
                    if (data!.isEmpty) {
                      return 'This Field is Required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                    height: screenHeight *
                        0.03), // Space between email and password
                CustomTextField(
                  label: 'Enter Your Password',
                  onChanged: (data) {
                    password = data;
                  },
                  validator: (data) {
                    if (data!.isEmpty) {
                      return 'This Field is Required';
                    }
                    return null;
                  },
                ),
                SizedBox(
                    height: screenHeight * 0.04), // Space before sign-in button
                CustomButton(
                  label: 'Sign In',
                  onPressed: () async {
                    //trigger validate method to validate input
                    if (formKey.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: email!, password: password!);
                        if (!context.mounted) return;
                        Navigator.of(context).pushNamed(HomeView.id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          customSnackBar(
                              context, 'No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          customSnackBar(context, 'Wrong password provided');
                        } else if (e.code == 'invalid-email') {
                          customSnackBar(
                              context, 'The email address is badly formatted.');
                        } else if (e.code == 'invalid-credential' ||
                            e.code == 'expired-action-code') {
                          customSnackBar(
                              context, 'Wrong Email and/or Password');
                        } else {
                          customSnackBar(context,
                              'An unexpected error occurred: ${e.message}');
                        }
                      } catch (e) {
                        if (!context.mounted) return;
                        customSnackBar(context, 'There was an error');
                      }
                      // if (!context.mounted) return;
                      // customSnackBar(context, 'You Successfully logged in');
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
      ),
    );
  }
}
