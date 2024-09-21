import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/src/configs/theme/theme.dart';
import 'package:school_app/src/core/auth/login/screen/login_screen.dart';
import 'package:school_app/src/core/auth/role_selection/screen/role_selection_screen.dart';
import 'package:school_app/src/core/splash_screen/screen/splash_screen.dart';
import 'package:school_app/src/modules/dashboard/screen/dashboard_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

final GoRouter _goRouter = GoRouter(
  initialLocation: AppScreen.splashScreen.path,
  routes: [
    GoRoute(
      path: AppScreen.dashboardScreen.path,
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: AppScreen.splashScreen.path,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppScreen.roleSelectionScreen.path,
      builder: (context, state) => const RoleSelectionScreen(),
    ),
    GoRoute(
      path: AppScreen.loginScreen.path,
      builder: (context, state) => const LoginScreen(),
    ),
  ],
);

enum AppScreen {
  dashboardScreen("/"),
  splashScreen("/splash"),
  roleSelectionScreen("/role-selection"),
  loginScreen("/login");

  final String path;
  const AppScreen(this.path);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _goRouter,
      theme: themeData,
    );
  }
}
