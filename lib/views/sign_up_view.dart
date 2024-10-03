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
    String? passwordConfirm;
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
              CustomTextField(
                label: 'Confirm Your Password',
                onChanged: (data) {
                  passwordConfirm = data;
                },
              ),

              SizedBox(
                  height: screenHeight * 0.04), // Space before sign-in button
              CustomButton(
                label: 'Sign Up',
                onPressed: password != passwordConfirm
                    ? null
                    : () async {
                        try {
                          if (validatePassword(password) != null) {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(validatePassword(password)!),
                              ),
                            );
                          }
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: email!,
                            password: password!,
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Weak Password, try stronger one'),
                              ),
                            );
                          } else if (e.code == 'email-already-in-use') {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Email is already used'),
                              ),
                            );
                          }
                          Navigator.of(context).pop();
                        } on TypeError catch (_) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Email or password is missing!'),
                            ),
                          );
                        } catch (e) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                            ),
                          );
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

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    } else if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    } else if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    } else if (!RegExp(r'[!@#\$&*~.,;:%^]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }
}
