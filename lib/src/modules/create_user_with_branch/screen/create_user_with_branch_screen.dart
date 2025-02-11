import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/src/common/widgets/loading_scaffold_widget.dart';
import 'package:school_app/src/core/auth/login/controller/login_controller.dart';
import 'package:school_app/src/core/splash_screen/controller/splash_controller.dart';
import 'package:school_app/src/modules/create_user_with_branch/controller/create_user_with_branch_controller.dart';

import '../../../../main.dart';
import '../../../common/app_setting.dart';
import '../../../common/model/custom_drop_down_menu_item.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_drop_down_picker.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../dashboard/models/user_type.dart';

class CreateUserWithBranchScreen extends StatefulWidget {
  const CreateUserWithBranchScreen({super.key});

  @override
  State<CreateUserWithBranchScreen> createState() =>
      _CreateUserWithBranchScreenState();
}

class _CreateUserWithBranchScreenState
    extends State<CreateUserWithBranchScreen> {
  final CreateUserWithBranchController _createUserWithBranchController =
      Get.put(CreateUserWithBranchController());
  final FocusNode _idInBranchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    _createUserWithBranchController.register(context);

    return GetBuilder<CreateUserWithBranchController>(
      builder: (controller) {
        return LoadingScaffoldWidget(
          isShowLoading: controller.isShowLoading,
          appBar: CustomAppBar(
            context,
            backgroundColor: AppColor.primaryColor,
            appBarType: AppBarType.generalType,
            title: "Create",
            isCenterTitle: true,
            onPressedBack: () {
              Get.delete<CreateUserWithBranchController>();
              context.pop();
            },
          ),
          body: Obx(
            () => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      left: AppStyle.horizontalPadding,
                      right: AppStyle.horizontalPadding,
                    ),
                    child: CustomDropDownPicker(
                      controller: _createUserWithBranchController
                          .universityBranchTextEditingController.value,
                      label: "Branch",
                      onSelected: (item) {
                        if (item == null) return;

                        _createUserWithBranchController
                            .universityBranchTextEditingController
                            .value
                            .text = item.title ?? '';
                        _createUserWithBranchController
                            .setSelectedUniversityBranch(item);
                      },
                      dropDownMenuEntryList: _createUserWithBranchController
                          .universityBranchDropDownItemList.value
                          .map((item) =>
                              DropdownMenuEntry<CustomDropDownMenuItem>(
                                value: item,
                                label: item.title,
                              ))
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16,
                      left: AppStyle.horizontalPadding,
                      right: AppStyle.horizontalPadding,
                    ),
                    child: CustomTextField(
                      focusNode: _idInBranchFocusNode,
                      errorDescription: _createUserWithBranchController
                          .invalidIdInBranchDescription.value,
                      isShowError: _createUserWithBranchController
                          .isInvalidIdInBranch.value,
                      controller: _createUserWithBranchController
                          .idInBranchTextEditingController.value,
                      onChangeTextField: (value) {
                        _createUserWithBranchController.resetIdInBranchError();
                      },
                      label: "ID in branch",
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppStyle.horizontalPadding,
                      left: AppStyle.horizontalPadding,
                      right: AppStyle.horizontalPadding,
                    ),
                    child: CustomButton(
                      onPressed: () {
                        _idInBranchFocusNode.unfocus();
                        _createUserWithBranchController.saveUser(
                          onSuccess: () {
                            Get.delete<SplashController>();
                            Get.delete<LoginController>();
                            Get.delete<CreateUserWithBranchController>();
                            context.go(
                              AppScreen.dashboardScreen.path,
                              extra: UserType.loggedInUser,
                            );
                          },
                        );
                      },
                      title: "Save",
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
