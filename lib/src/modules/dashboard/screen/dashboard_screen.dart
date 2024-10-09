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
import 'package:school_app/src/utils/widgets/custom_button.dart';
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
        onLanguagePressed: () {
          _showBottomSheet(context);
        },
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
                color: AppColor.background,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              height: 300,
              width: double.infinity,
              child: GridView.builder(
                padding: const EdgeInsets.all(AppStyle.horizontalPadding),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
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
                        case HomeGridItemType.attendant:
                          // context.go("");
                          break;
                        case HomeGridItemType.forEnrollment:
                          // context.go("");
                          break;
                        case HomeGridItemType.contact:
                          context.go(AppScreen.contactScreen.path);
                          break;
                        case HomeGridItemType.checkIn:
                          // context.go("");
                          break;
                        case HomeGridItemType.campus:
                          // context.go("");
                          break;
                        case HomeGridItemType.location:
                          // context.go("");
                          break;
                        case HomeGridItemType.billing:
                          // context.go("");
                          break;
                        case HomeGridItemType.scholarship:
                          context.go(AppScreen.scholarshipScreen.path);
                          break;
                        case HomeGridItemType.aboutUs:
                          context.go(AppScreen.aboutUsScreen.path);
                          break;
                        case HomeGridItemType.study:
                          // context.go("");
                          break;
                        case HomeGridItemType.event:
                          context.go(AppScreen.eventsScreen.path);
                          break;
                      }
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: AppStyle.horizontalPadding,
                bottom: 18,
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
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 115,
              decoration: const BoxDecoration(
                color: AppColor.background,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dashboardController.certificateFormatList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CertificateFormatItemWidget(
                    index: index,
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
                left: 20,
                top: 20,
                right: 20,
                bottom: 18,
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
              margin: const EdgeInsets.symmetric(horizontal: 20),
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
                left: 20,
                top: 20,
                right: 20,
                bottom: 18,
              ),
              child: Text(
                "Slide Show",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 16,
              ),
              child: CarouselSlider.builder(
                itemCount: dashboardController.imageSlideList.length,
                itemBuilder: (context, index, realIndex) {
                  return ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: CachedNetworkImage(
                      width: double.infinity,
                      imageUrl: dashboardController.imageSlideList[index],
                      fit: BoxFit.fill,
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 240,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 2),
                  viewportFraction: 0.9,
                  enlargeCenterPage: true,
                ),
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

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
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
                "Change Language",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 40),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: AppStyle.horizontalPadding,
                ),
                decoration: const BoxDecoration(
                  color: Color(0x617C7C7C),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppStyle.horizontalPadding,
                        vertical: 16,
                      ),
                      child: Image.asset(
                        "assets/dashboard/khmer.png",
                        fit: BoxFit.cover,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    Text(
                      "ភាសាខ្មែរ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black),
                    ),
                    const Spacer(),
                    const SizedBox(
                      height: 20,
                      width: 20,
                      child: Icon(
                        Icons.check_rounded,
                        color: Color(0xFF3283e0),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 12,
                  left: AppStyle.horizontalPadding,
                  right: AppStyle.horizontalPadding,
                ),
                decoration: const BoxDecoration(
                  color: Color(0x617C7C7C),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppStyle.horizontalPadding,
                        vertical: 16,
                      ),
                      child: Image.asset(
                        "assets/dashboard/english.png",
                        fit: BoxFit.cover,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    Text(
                      "English",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black),
                    ),
                    const Spacer(),
                    const SizedBox(
                      height: 20,
                      width: 20,
                      child: Icon(
                        Icons.check_rounded,
                        color: Color(0xFF3283e0),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 56,
                  left: AppStyle.horizontalPadding,
                  right: AppStyle.horizontalPadding,
                  bottom: AppStyle.horizontalPadding,
                ),
                child: CustomButton(
                  onPressed: () {
                    //
                  },
                  title: "Continue",
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
