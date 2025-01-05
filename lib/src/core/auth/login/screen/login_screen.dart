import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/src/common/app_setting.dart';
import 'package:school_app/src/core/auth/login/controller/login_controller.dart';

import '../../../../../main.dart';
import '../../../../common/model/custom_drop_down_menu_item.dart';
import '../../../../common/widgets/custom_drop_down_picker.dart';
import '../../../../common/widgets/custom_text_field.dart';
import '../../../../common/widgets/loading_container_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    _loginController.register(context);

    return GetBuilder<LoginController>(
      builder: (controller) {
        return LoadingContainerWidget(
          isShowLoading: _loginController.isShowLoading,
          child: Scaffold(
            backgroundColor: AppColor.primaryColor,
            body: SafeArea(
              child: Obx(
                () => GestureDetector(
                  onTap: () {
                    _emailFocusNode.unfocus();
                    _passwordFocusNode.unfocus();
                  },
                  child: SingleChildScrollView(
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
                            focusNode: _emailFocusNode,
                            errorDescription:
                                _loginController.invalidEmailDescription.value,
                            isShowError: _loginController.isInvalidEmail.value,
                            controller: _loginController
                                .emailTextEditingController.value,
                            onChangeTextField: (value) {
                              _loginController.resetUsernameError();
                            },
                            label: "Email",
                          ),
                        ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppStyle.horizontalPadding,
                          ),
                          child: CustomTextField(
                            focusNode: _passwordFocusNode,
                            errorDescription: _loginController
                                .invalidPasswordDescription.value,
                            isShowError:
                                _loginController.isInvalidPassword.value,
                            controller: _loginController
                                .passwordTextEditingController.value,
                            onChangeTextField: (value) {
                              _loginController.resetPasswordError();
                            },
                            obscureText: _loginController.isHidePassword.value,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                _loginController
                                    .changePasswordVisibilityState();
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
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppStyle.horizontalPadding,
                          ),
                          child: CustomDropDownPicker(
                            controller: _loginController
                                .userTypeTextEditingController.value,
                            label: "User Type",
                            onSelected: (item) {
                              if (item == null) return;
                              _loginController.userTypeTextEditingController
                                  .value.text = item.title ?? '';
                              _loginController.setSelectedUserType(item);
                            },
                            dropDownMenuEntryList: _loginController
                                .userTypeDropDownItemList.value
                                .map((item) =>
                                    DropdownMenuEntry<CustomDropDownMenuItem>(
                                      value: item,
                                      label: item.title,
                                    ))
                                .toList(),
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
                              _emailFocusNode.unfocus();
                              _passwordFocusNode.unfocus();
                              await _loginController.loginUser(
                                onSuccess: () {
                                  context.push(
                                    AppScreen.createUserWithBranch.path,
                                  );
                                },
                              );
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
          ),
        );
      },
    );
  }
}
