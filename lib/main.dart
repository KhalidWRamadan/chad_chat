import 'package:chad_chat/firebase_options.dart';
import 'package:chad_chat/views/home_view.dart';
import 'package:chad_chat/views/login_view.dart';
import 'package:chad_chat/views/sign_up_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        HomeView.id: (context) => const HomeView(),
      },
      initialRoute: LoginView.id,
    );
  }
}
