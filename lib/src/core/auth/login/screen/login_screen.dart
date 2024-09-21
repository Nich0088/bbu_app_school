import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/src/constants/app_setting.dart';
import 'package:school_app/src/core/auth/login/controller/login_controller.dart';
import 'package:school_app/src/utils/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());

    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 54),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  AppLogo.appLogo,
                  height: 93,
                  width: 133,
                ),
              ),
              const SizedBox(height: 64),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppStyle.horizontalPadding,
                ),
                child: CustomTextField(
                  controller:
                      loginController.usernameTextEditingController.value,
                  onChangeTextField: (value) {
                    //
                  },
                  label: "Username",
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppStyle.horizontalPadding,
                ),
                child: CustomTextField(
                  controller:
                      loginController.usernameTextEditingController.value,
                  onChangeTextField: (value) {
                    //
                  },
                  label: "Password",
                ),
              ),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    //
                  },
                  child: Text(
                    "Forgot Password?",
                    style: Theme.of(context).textTheme.bodySmall,
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
                    //
                  },
                  child: Text(
                    "Login",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
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
                    //
                  },
                  child: Text(
                    "Back",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
