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
  initialLocation: "/splash-screen",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: "/splash-screen",
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: "/role-selection",
      builder: (context, state) => const RoleSelectionScreen(),
    ),
    GoRoute(
      path: "/login",
      builder: (context, state) => const LoginScreen(),
    ),
  ],
);

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
