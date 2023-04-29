import 'package:flutter/material.dart';
import 'package:jotihunt/views/auth/login_screen.dart';

void main() {
  runApp(const Jotihunt());
}

class Jotihunt extends StatelessWidget {
  const Jotihunt({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jotihunt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}
