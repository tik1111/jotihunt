import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:jotihunt/cubit/login_cubit.dart';
import 'package:jotihunt/cubit/login_state.dart';
import 'package:jotihunt/views/auth/login_screen.dart';
import 'package:jotihunt/views/auth/register_screen.dart';
import 'package:jotihunt/views/maps/jotihunt_map_screen.dart';
import 'package:jotihunt/views/profile_page_screen.dart';

class AppRouter {
  final LoginCubit loginCubit;
  AppRouter(this.loginCubit);

  late final GoRouter router = GoRouter(
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: "/",
          builder: (BuildContext context, GoRouterState state) {
            return const ProfilePage();
          },
        ),
        GoRoute(
          path: "/login",
          builder: (BuildContext context, GoRouterState state) =>
              const LoginScreen(),
        ),
        GoRoute(
          path: "/register",
          builder: (BuildContext context, GoRouterState state) =>
              const RegisterScreen(),
        ),
        GoRoute(
          path: "/profile",
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(
          path: "/jotihuntmap",
          builder: (context, state) => const JotihuntMap(),
        ),
      ],
      redirect: (BuildContext context, GoRouterState state) {
        final bool loggedIn =
            loginCubit.state.status == AuthStatus.authenticated; //cubit
        final bool loggingIn = state.location == '/login';
        final bool registering = state.location == '/register';

        if (!loggedIn) {
          if (state.location == '/register') {
            return registering ? null : '/register';
          }
        }

        if (!loggedIn) {
          return loggingIn ? null : '/jotihuntmap';
        }

        if (loggingIn) {
          return '/';
        }
        return null;
      },
      refreshListenable: GoRouterRefreshStream(loginCubit.stream));
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription =
        stream.asBroadcastStream().listen((dynamic _) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

void main() async {
  await dotenv.load(fileName: ".env");
  //runApp(const Jotihunt());
  runApp(const Jotihunt());
}

class Jotihunt extends StatelessWidget {
  const Jotihunt({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Builder(builder: (context) {
        return MaterialApp.router(
          routerConfig: AppRouter(context.read<LoginCubit>()).router,
        );
      }),
    );
  }
}
