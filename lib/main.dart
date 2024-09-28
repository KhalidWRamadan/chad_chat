import 'package:chad_chat/views/login_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ChadChat());
}

class ChadChat extends StatelessWidget {
  const ChadChat({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginView(),
    );
  }
}
