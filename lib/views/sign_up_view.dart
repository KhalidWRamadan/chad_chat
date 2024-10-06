import 'package:chad_chat/components/custom_button.dart';
import 'package:chad_chat/components/custom_text_field.dart';
import 'package:chad_chat/constants/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  static const String id = 'SignUpView';

  //initializing a global key to act like a state flag gor checking values
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    String? email;

    String? password;

    String? passwordConfirm;

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
            //passing the key for the form to give access to all the child widgets
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
                  validator: (data) {
                    //check the entered text value and returning error messages
                    if (data!.isEmpty) {
                      return 'This Field is Required';
                    }
                    return null;
                  },
                  onChanged: (data) {
                    email = data;
                  },
                ),
                SizedBox(
                    height: screenHeight *
                        0.03), // Space between email and password
                CustomTextField(
                  label: 'Enter Your Password',
                  validator: (data) {
                    //check the entered text value and returning error messages
                    if (data!.isEmpty) {
                      return 'This Field is Required';
                    } else if (data != passwordConfirm) {
                      return 'Password is not Confirmed properly';
                    } else if (validatePassword(data) != null) {
                      return validatePassword(data);
                    }
                    return null;
                  },
                  onChanged: (data) {
                    password = data;
                  },
                ),
                SizedBox(
                    height: screenHeight *
                        0.03), // Space between email and password
                CustomTextField(
                  validator: (data) {
                    //check the entered text value and returning error messages
                    if (data!.isEmpty) {
                      return 'This Field is Required';
                    } else if (data != password) {
                      return 'Password is not Confirmed properly';
                    }
                    return null;
                  },
                  label: 'Confirm Your Password',
                  onChanged: (data) {
                    passwordConfirm = data;
                  },
                ),

                SizedBox(
                    height: screenHeight * 0.04), // Space before sign-in button
                CustomButton(
                    label: 'Sign Up',
                    onPressed: () async {
                      //check the current state of the textForm
                      //if it is valid continue the sign up process
                      if (formKey.currentState!.validate()) {
                        try {
                          String? validationMessage =
                              validatePassword(password);
                          if (validationMessage != null) {
                            if (!context.mounted) return;
                            customSnackBar(context, validationMessage);
                          }
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: email!,
                            password: password!,
                          );
                          //popping sign up view once succeding
                          if (!context.mounted) return;
                          Navigator.of(context).pop();
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            if (!context.mounted) return;
                            customSnackBar(
                                context, 'Weak Password, try stronger one');
                          } else if (e.code == 'email-already-in-use') {
                            if (!context.mounted) return;
                            customSnackBar(context, 'Email is already used');
                          }
                        } on TypeError catch (_) {
                          if (!context.mounted) return;
                          customSnackBar(
                              context, 'Email or password is missing!');
                        } catch (e) {
                          if (!context.mounted) return;
                          customSnackBar(context, e.toString());
                        }
                      }
                    }),
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
      ),
    );
  }

  void customSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
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
