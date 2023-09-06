import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:jotihunt/Cubit/fox_timer_cubit.dart';
import 'package:jotihunt/Cubit/login_cubit.dart';
import 'package:jotihunt/Cubit/login_state.dart';
import 'package:jotihunt/handlers/handler_streamsocket.dart';
import 'package:jotihunt/handlers/handler_webrequests.dart';
import 'package:jotihunt/views/auth/login_screen.dart';
import 'package:jotihunt/views/auth/register_screen.dart';
import 'package:jotihunt/views/map_screen.dart';
import 'package:jotihunt/views/profile_page_screen.dart';
import 'package:jotihunt/views/settings/settings_add_hint_screen.dart';
import 'package:jotihunt/views/settings/settings_game_screen.dart';
import 'package:jotihunt/views/settings/settings_huntcode_screen.dart';
import 'package:jotihunt/views/settings/settings_hunters_screen.dart';
import 'package:jotihunt/views/settings/settings_teams_screen.dart';
import 'package:jotihunt/views/settings_page_screen.dart';

class AppRouter {
  final LoginCubit loginCubit;
  AppRouter(this.loginCubit);

  late final GoRouter router = GoRouter(
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: "/",
          builder: (BuildContext context, GoRouterState state) {
            return const MainMapWidget();
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
          path: "/map",
          builder: (context, state) => const MainMapWidget(),
        ),
        GoRoute(
            path: "/settings",
            builder: (context, state) => const SettingsPage()),
        GoRoute(
          path: "/hunters",
          builder: (context, state) => const SettingsHuntersScreen(),
        ),
        GoRoute(
          path: "/teams",
          builder: (context, state) => const SettingsTeamScreen(),
        ),
        GoRoute(
          path: "/huntcode",
          builder: (context, state) => const SettingsHuntcodeScreen(),
        ),
        GoRoute(
          path: "/addhint",
          builder: (context, state) => const SettingsAddHintScreen(),
        ),
        GoRoute(
            path: '/gameEditor',
            builder: (context, state) => const SettingsGameScreen()),
      ],
      redirect: (BuildContext context, GoRouterState state) {
        final bool loggedIn =
            loginCubit.state.status == AuthStatus.authenticated; //cubit
        final bool loggingIn = state.uri.toString() == '/login';
        final bool registering = state.uri.toString() == '/register';

        if (!loggedIn) {
          if (state.uri.toString() == '/register') {
            return registering ? null : '/register';
          }
        }

        if (!loggedIn) {
          return loggingIn ? null : '/login';
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
  HandlerWebRequests.init();

  runApp(
    Jotihunt(),
  );
}

// ignore: must_be_immutable
class Jotihunt extends StatelessWidget {
  SocketConnection globalSocket = SocketConnection();
  Jotihunt({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => HuntTimeCubit(),
        ),
      ],
      child: Builder(builder: (context) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter(context.read<LoginCubit>()).router,
        );
      }),
    );
  }
}
