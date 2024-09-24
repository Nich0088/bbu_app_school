import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/main.dart';
import 'package:school_app/src/constants/app_setting.dart';
import 'package:school_app/src/modules/dashboard/controller/dashboard_controller.dart';
import 'package:school_app/src/modules/dashboard/models/home_grid_item_type.dart';
import 'package:school_app/src/modules/dashboard/models/user_type.dart';
import 'package:school_app/src/utils/widgets/custom_app_bar.dart';
import 'package:school_app/src/widgets/dashboard/certificate_format_item_widget.dart';
import 'package:school_app/src/widgets/dashboard/home_grid_item_widget.dart';
import 'package:school_app/src/widgets/dashboard/message_item_widget.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                shrinkWrap: true,
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
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: AppStyle.horizontalPadding,
                bottom: 12,
              ),
              child: Text(
                "Certificate format",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              height: 115,
              padding: const EdgeInsets.only(
                left: 12,
                top: 12,
                bottom: 12,
              ),
              decoration: const BoxDecoration(
                color: AppColor.cardColor,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dashboardController.certificateFormatList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CertificateFormatItemWidget(
                    item: dashboardController.certificateFormatList[index],
                    onTap: () {
                      //
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: AppStyle.horizontalPadding,
                bottom: 12,
              ),
              child: Text(
                "Message",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              height: 196,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dashboardController.messageList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return MessageItemWidget(
                    item: dashboardController.messageList[index],
                    isLastItem:
                        index == dashboardController.messageList.length - 1,
                    onTap: () {
                      //
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: AppStyle.horizontalPadding,
                bottom: 12,
              ),
              child: Text(
                "Slide Show",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            CarouselSlider.builder(
              itemCount: dashboardController.imageSlideList.length,
              itemBuilder: (context, index, realIndex) {
                return CachedNetworkImage(
                  imageUrl: dashboardController.imageSlideList[index],
                  fit: BoxFit.fill,
                );
              },
              options: CarouselOptions(
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                enlargeFactor: 0.4,
                autoPlay: true,
                autoPlayCurve: Curves.linear,
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
