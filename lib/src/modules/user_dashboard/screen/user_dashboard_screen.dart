import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/src/constants/app_setting.dart';
import 'package:school_app/src/modules/user_dashboard/controller/user_dashboard_controller.dart';
import 'package:school_app/src/utils/widgets/custom_app_bar.dart';
import 'package:school_app/src/widgets/user_dashboard/study_item_widget.dart';

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

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        debugPrint("Tab changed to: ${_tabController.index}");
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
    return Scaffold(
      appBar: CustomAppBar(
        context,
        backgroundColor: AppColor.primaryColor,
        isDashboardAppBar: false,
        title: "User Dashboard",
        isCenterTitle: true,
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
              text: "Schedule",
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
          _studyTab(),
          _resultTab(),
          _scheduleTab(),
          _chatTab(),
        ],
      ),
    );
  }

  Widget _studyTab() {
    return ListView.builder(
      itemCount: _userDashboardController.studyItemList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return StudyItemWidget(
          item: _userDashboardController.studyItemList[index],
          isLastItem:
              index == _userDashboardController.studyItemList.length - 1,
        );
      },
    );
  }

  Widget _resultTab() {
    return Center(
      child: Text(
        'Result',
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: AppColor.primaryColor),
      ),
    );
  }

  Widget _scheduleTab() {
    return Center(
      child: Text(
        'Schedule',
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: AppColor.primaryColor),
      ),
    );
  }

  Widget _chatTab() {
    return Center(
      child: Text(
        'Chat',
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(color: AppColor.primaryColor),
      ),
    );
  }
}
