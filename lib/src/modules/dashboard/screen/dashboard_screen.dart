import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/main.dart';
import 'package:school_app/src/constants/app_setting.dart';
import 'package:school_app/src/modules/dashboard/controller/dashboard_controller.dart';
import 'package:school_app/src/modules/dashboard/models/home_grid_item.dart';
import 'package:school_app/src/modules/dashboard/models/home_grid_item_type.dart';
import 'package:school_app/src/modules/dashboard/models/user_type.dart';
import 'package:school_app/src/utils/widgets/custom_app_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, this.userType});
  final UserType? userType;

  @override
  Widget build(BuildContext context) {
    switch (userType) {
      case null:
        return const SizedBox();
      case UserType.loggedInUser:
        return _setupViewForLoggedInUser(context);
      case UserType.guest:
        return _setupViewForGuestUser(context);
    }
  }

  Widget _setupViewForLoggedInUser(BuildContext context) {
    DashboardController dashboardController = Get.put(DashboardController());
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: CustomAppBar(
        context,
        backgroundColor: AppColor.primaryColor,
        isDashboardAppBar: true,
        username: "Elon Musk",
        imageUrl:
            "https://www.nmspacemuseum.org/wp-content/uploads/2019/03/Elon_Musk.jpg",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: AppStyle.horizontalPadding,
                left: AppStyle.horizontalPadding,
                right: AppStyle.horizontalPadding,
              ),
              decoration: const BoxDecoration(
                color: AppColor.cardColor,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              height: 300,
              width: double.infinity,
              child: GridView.builder(
                padding: const EdgeInsets.all(AppStyle.horizontalPadding),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Number of columns in the grid
                  childAspectRatio: 1.0, // Aspect ratio of each item
                  crossAxisSpacing: 12, // Spacing between columns
                  mainAxisSpacing: 12, // Spacing between rows
                ),
                // itemCount: getIt<DashboardController>().homeGridItemList.length,
                itemCount: dashboardController.homeGridItemList.length,
                itemBuilder: (context, index) {
                  return HomeGridItemWidget(
                    item: dashboardController.homeGridItemList[index],
                    onTap: () {
                      switch (
                          dashboardController.homeGridItemList[index].type) {
                        case HomeGridItemType.event:
                        // context.go("");
                        case HomeGridItemType.forEnrollment:
                        // context.go("");
                        case HomeGridItemType.checkIn:
                        // context.go("");
                        case HomeGridItemType.campus:
                        // context.go("");
                        case HomeGridItemType.location:
                        // context.go("");
                        case HomeGridItemType.billing:
                        // context.go("");
                        case HomeGridItemType.scholarship:
                          context.go(AppScreen.scholarshipScreen.path);
                        case HomeGridItemType.aboutUs:
                        // context.go("");
                        case HomeGridItemType.study:
                        // context.go("");
                        case HomeGridItemType.attendant:
                        // context.go("");
                      }
                    },
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: AppStyle.horizontalPadding),
              width: double.infinity,
              height: 300,
              decoration: const BoxDecoration(
                color: AppColor.infoColor,
              ),
            ),
            Container(
              width: double.infinity,
              height: 300,
              decoration: const BoxDecoration(
                color: AppColor.warningColor,
              ),
            ),
            Container(
              width: double.infinity,
              height: 300,
              decoration: const BoxDecoration(
                color: AppColor.errorColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _setupViewForGuestUser(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.errorColor,
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}

class HomeGridItemWidget extends StatelessWidget {
  const HomeGridItemWidget({
    super.key,
    required this.item,
    required this.onTap,
  });

  final HomeGridItem item;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(
            0xFFC2DBFF,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [AppStyle.boxShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              item.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 4),
            Text(
              item.title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColor.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
