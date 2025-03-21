import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/main.dart';

import '../../../modules/dashboard/models/user_type.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SplashController controller = Get.put(SplashController());
    return _displaySplashScreenAndDoAction(
      context: context,
      action: () {
        controller.determineRoute(
          actionOnTokenExist: () {
            context.go(
              AppScreen.dashboardScreen.path,
              extra: UserType.loggedInUser,
            );
          },
          actionOnTokenNotExist: () {
            context.go(
              AppScreen.roleSelectionScreen.path,
            );
          },
        );
      },
    );
  }

  Widget _displaySplashScreenAndDoAction({
    required BuildContext context,
    required VoidCallback action,
  }) {
    Future.delayed(
      const Duration(milliseconds: 1000),
      () {
        action.call();
      },
    );
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset(
          "assets/splas_screen.jpg",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
