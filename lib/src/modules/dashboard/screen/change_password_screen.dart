import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/src/modules/dashboard/controller/change_password_controller.dart';

import '../../../common/app_setting.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../common/widgets/loading_scaffold_widget.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final ChangePasswordController _changePasswordController =
      Get.put(ChangePasswordController());
  final FocusNode _currentPasswordFocusNode = FocusNode();
  final FocusNode _newPasswordFocusNode = FocusNode();
  final FocusNode _confirmNewPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePasswordController>(
      builder: (controller) {
        return LoadingScaffoldWidget(
          isShowLoading: controller.isShowLoading,
          appBar: CustomAppBar(
            context,
            backgroundColor: AppColor.primaryColor,
            appBarType: AppBarType.generalType,
            title: "Change Password",
            isCenterTitle: true,
            onPressedBack: () {
              Get.delete<ChangePasswordController>();
              context.pop();
            },
          ),
          body: Obx(
            () => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppStyle.horizontalPadding,
                    ),
                    child: CustomTextField(
                      focusNode: _currentPasswordFocusNode,
                      errorDescription: _changePasswordController
                          .invalidCurrentPasswordDescription.value,
                      isShowError: _changePasswordController
                          .isInvalidCurrentPassword.value,
                      controller: _changePasswordController
                          .currentPasswordTextEditingController.value,
                      onChangeTextField: (value) {
                        _changePasswordController.resetCurrentPasswordError();
                      },
                      obscureText:
                          _changePasswordController.isHideCurrentPassword.value,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _changePasswordController
                              .changeCurrentPasswordVisibilityState();
                        },
                        child: Icon(
                          _changePasswordController
                                      .isHideCurrentPassword.value ==
                                  true
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      label: "Current Password",
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppStyle.horizontalPadding,
                    ),
                    child: CustomTextField(
                      focusNode: _newPasswordFocusNode,
                      errorDescription: _changePasswordController
                          .invalidNewPasswordDescription.value,
                      isShowError:
                          _changePasswordController.isInvalidNewPassword.value,
                      controller: _changePasswordController
                          .newPasswordTextEditingController.value,
                      onChangeTextField: (value) {
                        _changePasswordController.resetNewPasswordError();
                      },
                      obscureText:
                          _changePasswordController.isHideNewPassword.value,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _changePasswordController
                              .changeNewPasswordVisibilityState();
                        },
                        child: Icon(
                          _changePasswordController.isHideNewPassword.value ==
                                  true
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      label: "New Password",
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppStyle.horizontalPadding,
                    ),
                    child: CustomTextField(
                      focusNode: _confirmNewPasswordFocusNode,
                      errorDescription: _changePasswordController
                          .invalidConfirmNewPasswordDescription.value,
                      isShowError: _changePasswordController
                          .isInvalidConfirmNewPassword.value,
                      controller: _changePasswordController
                          .confirmNewPasswordTextEditingController.value,
                      onChangeTextField: (value) {
                        _changePasswordController
                            .resetConfirmNewPasswordError();
                      },
                      obscureText: _changePasswordController
                          .isHideConfirmNewPassword.value,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _changePasswordController
                              .changeConfirmNewPasswordVisibilityState();
                        },
                        child: Icon(
                          _changePasswordController
                                      .isHideConfirmNewPassword.value ==
                                  true
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      label: "Confirm New Password",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 32,
                      horizontal: AppStyle.horizontalPadding,
                    ),
                    child: FilledButton(
                      onPressed: () {
                        // context.pop();
                      },
                      child: Text(
                        "Change Password",
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
      },
    );
  }
}
