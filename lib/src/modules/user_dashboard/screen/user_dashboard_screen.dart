import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/main.dart';
import 'package:school_app/src/common/app_setting.dart';
import 'package:school_app/src/common/widgets/custom_button.dart';
import 'package:school_app/src/common/widgets/loading_scaffold_widget.dart';
import 'package:school_app/src/modules/create_user_with_branch/model/user_type_result.dart';
import 'package:school_app/src/modules/user_dashboard/controller/user_dashboard_controller.dart';
import 'package:school_app/src/modules/user_dashboard/model/class_schedule_result.dart';

import '../../../common/model/custom_drop_down_menu_item.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_drop_down_picker.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../common/widgets/user_dashboard/schedule_item_widget.dart';
import '../../../common/widgets/user_dashboard/study_item_widget.dart';
import '../../../common/widgets/user_dashboard/study_result_item_widget.dart';

class UserDashboardScreen extends StatefulWidget {
  const UserDashboardScreen({super.key, this.userTypeData});

  final UserTypeData? userTypeData;

  @override
  State<UserDashboardScreen> createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final UserDashboardController _userDashboardController =
      Get.put(UserDashboardController());
  final FocusNode _scheduleCodeFocusNode = FocusNode();
  int classTabIndex = 2;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length:
          widget.userTypeData?.usertypeName?.toLowerCase() == 'student' ? 4 : 3,
      vsync: this,
    );
    classTabIndex =
        widget.userTypeData?.usertypeName?.toLowerCase() == 'student' ? 2 : 1;

    _tabController.addListener(() async {
      if (_tabController.indexIsChanging) {
        debugPrint("Tab changed to: ${_tabController.index}");
        _userDashboardController.setSelectedTabViewIndex(_tabController.index);
        switch (_tabController.index) {
          case 1:
            await _userDashboardController.getStudentScore();
            break;
          case 2:
            await _userDashboardController.initializeDataForClassTab();
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _userDashboardController.register(context);

    return GetBuilder<UserDashboardController>(
      builder: (controller) {
        return LoadingScaffoldWidget(
          isShowLoading: controller.isShowLoading,
          appBar: CustomAppBar(
            context,
            backgroundColor: AppColor.primaryColor,
            appBarType: AppBarType.generalType,
            title: "User Dashboard",
            isCenterTitle: true,
            onPressedBack: () {
              Get.delete<UserDashboardController>();
              context.pop();
            },
            bottom: TabBar(
              controller: _tabController,
              labelColor: AppColor.textPrimaryColor,
              indicatorColor: const Color(0xCCE25425),
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: AppColor.textPrimaryColor.withOpacity(0.3),
              tabs: [
                const Tab(
                  text: "Study",
                ),
                if (widget.userTypeData?.usertypeName?.toLowerCase() ==
                    'student')
                  const Tab(
                    text: "Result",
                  ),
                const Tab(
                  text: "Class",
                ),
                const Tab(
                  text: "Chat",
                ),
              ],
            ),
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              _studyTab(context),
              if (widget.userTypeData?.usertypeName?.toLowerCase() == 'student')
                _resultTab(),
              _classTab(),
              _chatTab(),
            ],
          ),
          floatingActionButton: controller.selectedTabViewIndex == classTabIndex
              ? FloatingActionButton(
                  onPressed: () {
                    _showEnterScheduleBottomSheet(context);
                  },
                  shape: const CircleBorder(),
                  backgroundColor: AppColor.cardColor,
                  child: const Icon(
                    size: 32,
                    Icons.add_outlined,
                    color: AppColor.primaryColor,
                  ),
                )
              : null,
        );
      },
    );
  }

  Widget _studyTab(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (_userDashboardController.studentIdList.value.isNotEmpty)
            GestureDetector(
              onTap: () {
                _showSelectStudentIdBottomSheet(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  right: 16,
                ),
                child: Card(
                  color: AppColor.primaryColor,
                  elevation: 4,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _userDashboardController.selectedStudentId.value,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          if (_userDashboardController.studentProfileDataList.value.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: _userDashboardController
                    .studentProfileDataList.value.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return StudyItemWidget(
                    item: _userDashboardController
                        .studentProfileDataList.value[index],
                    isLastItem: true,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _resultTab() {
    return Obx(
      () => _userDashboardController.studentScoreList.value.isNotEmpty
          ? ListView.builder(
              itemCount: _userDashboardController.studentScoreList.value.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return StudyResultItemWidget(
                  item: _userDashboardController.studentScoreList.value[index],
                );
              },
            )
          : const SizedBox(),
    );
  }

  Widget _classTab() {
    return Obx(
      () => RefreshIndicator(
        child: ListView.builder(
          itemCount: _userDashboardController.classScheduleResult.value
                      .classScheduleDataList?.isNotEmpty ==
                  true
              ? _userDashboardController
                  .classScheduleResult.value.classScheduleDataList?.length
              : 0,
          itemBuilder: (context, index) {
            ClassScheduleData? item = _userDashboardController
                .classScheduleResult.value.classScheduleDataList?[index];

            if (item == null) return const SizedBox();

            return ScheduleItemWidget(
              item: item,
              isLastItem: index ==
                  (_userDashboardController.classScheduleResult.value
                              .classScheduleDataList?.length ??
                          0) -
                      1,
              onClick: () {
                context.push(
                  AppScreen.studentClassDetailScreen.path,
                  extra: item,
                );
              },
            );
          },
        ),
        onRefresh: () async {
          _userDashboardController.getClassList();
        },
      ),
    );
  }

  Widget _chatTab() {
    return Center(
      child: Text(
        'Coming Soon',
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: AppColor.primaryColor),
      ),
    );
  }

  void _showSelectStudentIdBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Obx(
          () => Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                topLeft: Radius.circular(16),
              ),
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: 60,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: Color(0x617C7C7C),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                const SizedBox(height: 24),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      _userDashboardController.studentIdList.value.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: index == 0 ? 0 : 16,
                        left: 20,
                        right: 20,
                        bottom: index ==
                                _userDashboardController
                                        .studentIdList.value.length -
                                    1
                            ? 16
                            : 0,
                      ),
                      child: InkWell(
                        onTap: () async {
                          context.pop();
                          await _userDashboardController.setSelectedStudentId(
                            _userDashboardController.studentIdList.value[index],
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          color: AppColor.cardColor,
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            child: Text(
                              _userDashboardController
                                  .studentIdList.value[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: AppColor.primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEnterScheduleBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Obx(
          () => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  topLeft: Radius.circular(16),
                ),
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    width: 60,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: Color(0x617C7C7C),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Please Enter Schedule Code Bellow',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppStyle.horizontalPadding,
                    ),
                    child: CustomDropDownPicker(
                      controller: _userDashboardController
                          .universityBranchTextEditingController.value,
                      label: "Branch",
                      onSelected: (item) {
                        if (item == null) return;
                        _userDashboardController
                            .universityBranchTextEditingController
                            .value
                            .text = item.title ?? '';
                        _userDashboardController
                            .setSelectedUniversityBranch(item);
                      },
                      dropDownMenuEntryList: _userDashboardController
                          .universityBranchDropDownItemList.value
                          .map((item) =>
                              DropdownMenuEntry<CustomDropDownMenuItem>(
                                value: item,
                                label: item.title,
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppStyle.horizontalPadding,
                    ),
                    child: CustomTextField(
                      focusNode: _scheduleCodeFocusNode,
                      errorDescription: _userDashboardController
                          .invalidScheduleCodeDescription.value,
                      isShowError:
                          _userDashboardController.isInvalidScheduleCode.value,
                      controller: _userDashboardController
                          .scheduleCodeTextEditingController.value,
                      onChangeTextField: (value) {
                        _userDashboardController.resetScheduleCodeValidation();
                      },
                      label: 'Schedule Code',
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppStyle.horizontalPadding,
                    ),
                    child: CustomDropDownPicker(
                      controller: _userDashboardController
                          .studentIdTextEditingController.value,
                      label: "Student Id",
                      onSelected: (item) {
                        if (item == null) return;
                        _userDashboardController.studentIdTextEditingController
                            .value.text = item.title ?? '';
                        _userDashboardController
                            .setSelectedStudentIdClassTab(item);
                      },
                      dropDownMenuEntryList: _userDashboardController
                          .studentIdDropDownItemList.value
                          .map((item) =>
                              DropdownMenuEntry<CustomDropDownMenuItem>(
                                value: item,
                                label: item.title,
                              ))
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppStyle.horizontalPadding,
                      vertical: 24,
                    ),
                    child: CustomButton(
                      onPressed: () async {
                        await _userDashboardController.linkClassSchedule(
                          actionOnSuccess: () {
                            context.pop();
                          },
                        );
                      },
                      title: 'Add Class',
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
