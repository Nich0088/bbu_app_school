import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/main.dart';
import 'package:school_app/src/constants/app_setting.dart';
import 'package:school_app/src/modules/dashboard/models/user_type.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Please Select Role",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 64),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppStyle.horizontalPadding,
            ),
            child: FilledButton(
              onPressed: () {
                context.push(AppScreen.loginScreen.path);
              },
              child: Text(
                "User",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppStyle.horizontalPadding,
            ),
            child: FilledButton(
              onPressed: () {
                context.push(
                  AppScreen.dashboardScreen.path,
                  extra: UserType.guest,
                );
              },
              child: Text(
                "Guest",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
