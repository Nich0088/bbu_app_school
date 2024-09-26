import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/src/configs/theme/theme.dart';
import 'package:school_app/src/core/auth/login/screen/about_us_screen.dart';
import 'package:school_app/src/core/auth/login/screen/events_screen.dart';
import 'package:school_app/src/core/auth/login/screen/login_screen.dart';
import 'package:school_app/src/core/auth/login/screen/scholarship_screen.dart';
import 'package:school_app/src/core/auth/role_selection/screen/role_selection_screen.dart';
import 'package:school_app/src/core/service_locator/service_locator.dart';
import 'package:school_app/src/core/splash_screen/screen/splash_screen.dart';
import 'package:school_app/src/modules/dashboard/models/user_type.dart';
import 'package:school_app/src/modules/dashboard/screen/dashboard_screen.dart';
import 'package:school_app/src/utils/helpers/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.init();
  configurationDependencies();
  runApp(const MyApp());
}

final GoRouter _goRouter = GoRouter(
  initialLocation: AppScreen.splashScreen.path,
  routes: [
    GoRoute(
      path: AppScreen.dashboardScreen.path,
      builder: (context, state) {
        final UserType? userType = state.extra as UserType?;
        return DashboardScreen(userType: userType);
      },
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
    GoRoute(
      path: AppScreen.scholarshipScreen.path,
      builder: (context, state) => const ScholarshipScreen(),
    ),
    GoRoute(
      path: AppScreen.aboutUsScreen.path,
      builder: (context, state) => const AboutUsScreen(),
    ),
    GoRoute(
      path: AppScreen.eventsScreen.path,
      builder: (context, state) => const EventsScreen(),
    ),
  ],
);

enum AppScreen {
  dashboardScreen("/"),
  splashScreen("/splash"),
  roleSelectionScreen("/role-selection"),
  loginScreen("/login"),
  scholarshipScreen("/scholarship-screen"),
  aboutUsScreen("/aboutUs-screen"),
  eventsScreen("/events-screen");

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
