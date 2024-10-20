import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/src/constants/app_setting.dart';
import 'package:school_app/src/core/auth/login/controller/login_controller.dart';

import '../../../../common/widgets/custom_text_field.dart';
import '../../../../common/widgets/loading_container_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) {
        return LoadingContainerWidget(
          isShowLoading: _loginController.isShowLoading,
          child: Scaffold(
            backgroundColor: AppColor.primaryColor,
            body: SafeArea(
              child: Obx(
                () => SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 80),
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          AppLogo.appLogo,
                          height: 150,
                          width: 110,
                        ),
                      ),
                      const SizedBox(height: 64),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppStyle.horizontalPadding,
                        ),
                        child: CustomTextField(
                          errorDescription:
                              _loginController.invalidUsernameDescription.value,
                          isShowError: _loginController.isInvalidUsername.value,
                          controller: _loginController
                              .usernameTextEditingController.value,
                          onChangeTextField: (value) {
                            _loginController.resetUsernameError();
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
                          errorDescription:
                              _loginController.invalidPasswordDescription.value,
                          isShowError: _loginController.isInvalidPassword.value,
                          controller: _loginController
                              .passwordTextEditingController.value,
                          onChangeTextField: (value) {
                            _loginController.resetPasswordError();
                          },
                          obscureText: _loginController.isHidePassword.value,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _loginController.changePasswordVisibilityState();
                            },
                            child: Icon(
                              _loginController.isHidePassword.value == true
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          label: "Password",
                        ),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            debugPrint("Forgot password?");
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Text(
                              "Forgot Password?",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppStyle.horizontalPadding,
                        ),
                        child: FilledButton(
                          onPressed: () async {
                            // AppDialogHelper().showErrorDialog(
                            //   context,
                            //   errorCode: "errorCode",
                            //   errorMessage: "errorMessage",
                            // );
                            await _loginController.loginUser();
                            // context.push(
                            //   AppScreen.dashboardScreen.path,
                            //   extra: UserType.loggedInUser,
                            // );
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
                            context.pop();
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
            ),
          ),
        );
      },
    );
  }
}
