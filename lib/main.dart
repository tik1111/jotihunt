import 'package:flutter/material.dart';
import 'package:jotihunt/views/auth/login_screen.dart';
import 'package:jotihunt/views/profile_page_screen.dart';

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
      //home: const ProfilePage(),
      routes: {
        '/': (context) => const LoginScreen(),
        '/login': (context) => const LoginScreen(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
