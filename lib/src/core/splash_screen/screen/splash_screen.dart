import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/main.dart';

import '../../../modules/dashboard/models/user_type.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(milliseconds: 3000),
      () {
        context.go(
          AppScreen.contactScreen.path,
          extra: UserType.loggedInUser,
        );
      },
    );
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset(
          "assets/splash_screen_background.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
