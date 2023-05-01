import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:jotihunt/views/auth/login_screen.dart';
import 'package:jotihunt/views/auth/register_screen.dart';
import 'package:jotihunt/views/profile_page_screen.dart';

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: "/login",
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: "/register",
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: "/profile",
      builder: (context, state) => const ProfilePage(),
    ),
  ],
);

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const Jotihunt());
}

class Jotihunt extends StatelessWidget {
  const Jotihunt({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: "Go Router",
    );

    //(
    //  title: 'Jotihunt',
    //  theme: ThemeData(
    //    primarySwatch: Colors.blue,
    //  ),
    //  //home: const ProfilePage(),
    //  routes: {
    //    '/': (context) => const LoginScreen(),
    //    '/register': (context) => const RegisterScreen(),
    //    '/login': (context) => const LoginScreen(),
    //    '/profile': (context) => const ProfilePage(),
    //  },
    //);
  }
}
