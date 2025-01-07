import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/src/common/app_setting.dart';
import 'package:school_app/src/common/widgets/loading_scaffold_widget.dart';
import 'package:school_app/src/modules/user_dashboard/controller/user_dashboard_controller.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/user_dashboard/schedule_item_widget.dart';
import '../../../common/widgets/user_dashboard/study_item_widget.dart';
import '../../../common/widgets/user_dashboard/study_result_item_widget.dart';
import '../model/class_time_schedule_result.dart';

class UserDashboardScreen extends StatefulWidget {
  const UserDashboardScreen({super.key});

  @override
  State<UserDashboardScreen> createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final UserDashboardController _userDashboardController =
      Get.put(UserDashboardController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    _tabController.addListener(() async {
      if (_tabController.indexIsChanging) {
        debugPrint("Tab changed to: ${_tabController.index}");
        switch (_tabController.index) {
          case 1:
            await _userDashboardController.getStudentScore();
            break;
          case 2:
            await _userDashboardController.getClassSchedule();
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
    return GetBuilder<UserDashboardController>(builder: (controller) {
      return LoadingScaffoldWidget(
        isShowLoading: controller.isShowLoading,
        appBar: CustomAppBar(
          context,
          backgroundColor: AppColor.primaryColor,
          isDashboardAppBar: false,
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
            tabs: const [
              Tab(
                text: "Study",
              ),
              Tab(
                text: "Result",
              ),
              Tab(
                text: "Class",
              ),
              Tab(
                text: "Chat",
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _studyTab(context),
            _resultTab(),
            _classTab(),
            _chatTab(),
          ],
        ),
      );
    });
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
      () => _userDashboardController.classTimeScheduleResult.value
                  .classTimeScheduleDataList?.isNotEmpty ==
              true
          ? ListView.builder(
              itemCount: _userDashboardController.classTimeScheduleResult.value
                  .classTimeScheduleDataList?.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                ClassTimeScheduleData? item = _userDashboardController
                    .classTimeScheduleResult
                    .value
                    .classTimeScheduleDataList?[index];

                if (item == null) return const SizedBox();

                return ScheduleItemWidget(
                  item: item,
                  isLastItem: index ==
                      (_userDashboardController.classTimeScheduleResult.value
                                  .classTimeScheduleDataList?.length ??
                              0) -
                          1,
                  onClick: () {
                    debugPrint(jsonEncode(item));
                  },
                );
              },
            )
          : const SizedBox(),
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
}
