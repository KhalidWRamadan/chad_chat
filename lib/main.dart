import 'package:chad_chat/views/login_view.dart';
import 'package:chad_chat/views/sign_up_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ChadChat());
}

class ChadChat extends StatelessWidget {
  const ChadChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginView.id: (context) => const LoginView(),
        SignUpView.id: (context) => const SignUpView(),
      },
      initialRoute: LoginView.id,
    );
  }
}
