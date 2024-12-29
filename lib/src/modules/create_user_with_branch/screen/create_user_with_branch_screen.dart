import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/src/common/widgets/loading_scaffold_widget.dart';
import 'package:school_app/src/modules/create_user_with_branch/controller/create_user_with_branch_controller.dart';

import '../../../../main.dart';
import '../../../common/app_setting.dart';
import '../../../common/model/custom_drop_down_menu_item.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_drop_down_picker.dart';
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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateUserWithBranchController>(
      builder: (controller) {
        return LoadingScaffoldWidget(
          isShowLoading: controller.isShowLoading,
          appBar: CustomAppBar(
            context,
            backgroundColor: AppColor.primaryColor,
            isDashboardAppBar: false,
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
                        _createUserWithBranchController
                            .universityBranchTextEditingController
                            .value
                            .text = item?.title ?? '';
                        _createUserWithBranchController
                            .selectedUniversityBranchId.value = item?.id ?? -1;
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
                    child: CustomDropDownPicker(
                      controller: _createUserWithBranchController
                          .userTypeTextEditingController.value,
                      label: "User Type",
                      onSelected: (item) {
                        _createUserWithBranchController
                            .userTypeTextEditingController
                            .value
                            .text = item?.title ?? '';
                      },
                      dropDownMenuEntryList: _createUserWithBranchController
                          .userTypeDropDownItemList.value
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
                    child: Text(
                      'ID in branch : ${_createUserWithBranchController.selectedUniversityBranchId.value >= 0 ? _createUserWithBranchController.selectedUniversityBranchId.value : ''}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColor.textSecondaryColor,
                          ),
                      textAlign: TextAlign.start,
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
                        context.go(
                          AppScreen.dashboardScreen.path,
                          extra: UserType.loggedInUser,
                        );
                      },
                      title: "Create",
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
