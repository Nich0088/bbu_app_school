import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/main.dart';
import 'package:school_app/src/common/app_setting.dart';
import 'package:school_app/src/common/helpers/app_date_formatter.dart';
import 'package:school_app/src/common/widgets/loading_container_widget.dart';
import 'package:school_app/src/modules/dashboard/controller/dashboard_controller.dart';
import 'package:school_app/src/modules/dashboard/models/language.dart';
import 'package:school_app/src/modules/dashboard/models/user_type.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/dashboard/certificate_format_item_widget.dart';
import '../../../common/widgets/dashboard/home_grid_item_widget.dart';
import '../../../common/widgets/dashboard/message_item_widget.dart';
import '../models/home_grid_item_type.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen(
      {super.key, this.userType, this.screenTitle, this.imageUrl});

  final String? screenTitle;
  final String? imageUrl;

  final UserType? userType;

  @override
  Widget build(BuildContext context) {
    DashboardController dashboardController = Get.put(DashboardController());
    dashboardController.register(context);
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
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    DashboardController dashboardController = Get.put(DashboardController());
    return GetBuilder<DashboardController>(builder: (controller) {
      return LoadingContainerWidget(
        isShowLoading: controller.isShowLoading,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: AppColor.primaryColor,
          appBar: CustomAppBar(
            context,
            backgroundColor: AppColor.primaryColor,
            isDashboardAppBar: true,
            username:
                '${dashboardController.userProfileData.value.firstname} ${dashboardController.userProfileData.value.lastname}',
            imageUrl: dashboardController.userProfileData.value.photo ?? '',
            onLanguagePressed: () async {
              _showBottomSheet(context);
            },
            onViewProfile: () {
              scaffoldKey.currentState?.openDrawer();
            },
            automaticallyImplyLeading: false,
          ),
          drawer: Drawer(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        AppLogo.bbucampus,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ClipOval(
                        child: CachedNetworkImage(
                          imageUrl:
                              dashboardController.userProfileData.value.photo ??
                                  '',
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        '${dashboardController.userProfileData.value.firstname} ${dashboardController.userProfileData.value.lastname}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              // color: AppColor.textSecondaryColor,
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                      ),
                      Text(
                        dashboardController
                                .userProfileData.value.contactPhone ??
                            '',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              // color: AppColor.textSecondaryColor,
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "ID :",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              // color: AppColor.textSecondaryColor,
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          dashboardController.userProfileData.value.id ?? '',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    // color: AppColor.textSecondaryColor,
                                    color: Colors.black,
                                    fontSize: 16.0,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Name in Khmer :",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              // color: AppColor.textSecondaryColor,
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        dashboardController.userProfileData.value.fullNameKh ??
                            '',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: AppFontFamily.khmerFontFamily,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Name in English :",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              // color: AppColor.textSecondaryColor,
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        "SIM SREY NUCH",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              // color: AppColor.textSecondaryColor,
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Gender :",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              // color: AppColor.textSecondaryColor,
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        dashboardController.userProfileData.value.sex ?? '',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              // color: AppColor.textSecondaryColor,
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Date of Birth :",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              // color: AppColor.textSecondaryColor,
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        AppDateFormatter.formatDateWithLocalTimeZone(
                              pattern: AppDateFormatter.monthCommaDateYear,
                              dateString:
                                  dashboardController.userProfileData.value.dob,
                            ) ??
                            '',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Place of Birth :",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              // color: AppColor.textSecondaryColor,
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        "Disable",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              // color: AppColor.textSecondaryColor,
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                      ),
                      // Text(
                      //   '${dashboardController.userProfileData.value.pobVillage}, ${dashboardController.userProfileData.value.pobCommune}, ${dashboardController.userProfileData.value.pobDistrict}, ${dashboardController.userProfileData.value.pobProvince}',
                      //   textAlign: TextAlign.center,
                      //   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      //         // color: AppColor.textSecondaryColor,
                      //         color: Colors.black,
                      //         fontSize: 16.0,
                      //       ),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Phone Number :",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              // color: AppColor.textSecondaryColor,
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        dashboardController
                                .userProfileData.value.contactPhone ??
                            '',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              // color: AppColor.textSecondaryColor,
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Email :",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              // color: AppColor.textSecondaryColor,
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        dashboardController.userProfileData.value.userName ??
                            '',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              // color: AppColor.textSecondaryColor,
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "About Us",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              // color: AppColor.textSecondaryColor,
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 218,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          _logOutUser(action: () {
                            context.go(AppScreen.splashScreen.path);
                          });
                        },
                        child: Text(
                          "Logout",
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.red,
                                    fontSize: 16.0,
                                  ),
                        ),
                      ),
                      // const SizedBox(height: 14.0),
                      Image.asset(
                        "assets/app_logo.png",
                        // Replace with your image path
                        width: 35, // Adjust size as needed
                        height: 50,
                      ),
                      const SizedBox(height: 14.0),
                      // Add spacing between the image and text
                      Text(
                        "App Version: V 5.0.29",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.black87,
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                  ),
                  height: 300,
                  width: double.infinity,
                  child: GridView.builder(
                    // padding: const EdgeInsets.all(AppStyle.horizontalPadding),
                    padding: const EdgeInsets.only(
                        left: 12, top: 12, bottom: 12, right: 10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      mainAxisExtent:
                          (MediaQuery.of(context).size.width - 96) / 3,
                    ),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    // itemCount: getIt<DashboardController>().homeGridItemList.length,
                    itemCount: dashboardController.homeGridItemList.length,
                    itemBuilder: (context, index) {
                      return HomeGridItemWidget(
                        item: dashboardController.homeGridItemList[index],
                        onTap: () {
                          switch (dashboardController
                              .homeGridItemList[index].type) {
                            case HomeGridItemType.forEnrollment:
                              context.push(
                                  AppScreen.registrationApplicationScreen.path);
                              break;
                            case HomeGridItemType.contact:
                              context.push(AppScreen.contactScreen.path);
                              break;
                            case HomeGridItemType.campus:
                              context.push(AppScreen.campusScreen.path);
                              break;
                            case HomeGridItemType.location:
                              context.push(AppScreen.locationScreen.path);
                              break;
                            case HomeGridItemType.billing:
                              // context.push("");
                              break;
                            case HomeGridItemType.scholarship:
                              context.push(AppScreen.scholarshipScreen.path);
                              break;
                            case HomeGridItemType.aboutUs:
                              context.push(AppScreen.aboutUsScreen.path);
                              break;
                            case HomeGridItemType.study:
                              context.push(AppScreen.userDashboardScreen.path);
                              break;
                            case HomeGridItemType.event:
                              context.push(AppScreen.eventsScreen.path);
                              break;
                            case HomeGridItemType.video:
                              context.push(AppScreen.videoScreen.path);
                              break;
                            case HomeGridItemType.apply:
                              context.push(AppScreen.applyScreen.path);
                              break;
                            case HomeGridItemType.calendar:
                              context.push(AppScreen.calendarScreen.path);
                              break;
                            case HomeGridItemType.faq:
                              context.push(AppScreen.faqScreen.path);
                              break;
                            case HomeGridItemType.attendant:
                              context.push(AppScreen.faqScreen.path);
                              break;
                            case HomeGridItemType.checkIn:
                            // TODO: Handle this case.
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
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
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
                          context.push(
                            AppScreen.certificateFormatScreen.path,
                            extra: dashboardController
                                .certificateFormatList[index],
                          );
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
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: SizedBox(
                    // margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    height: 196,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dashboardController.messageList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return MessageItemWidget(
                          item: dashboardController.messageList[index],
                          isLastItem: index ==
                              dashboardController.messageList.length - 1,
                          onTap: () {
                            //
                          },
                        );
                      },
                    ),
                  ),
                ),
                if (dashboardController.slideBannerList.value.data != null)
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
                if (dashboardController.slideBannerList.value.data != null)
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 16,
                    ),
                    child: CarouselSlider.builder(
                      itemCount: dashboardController
                          .slideBannerList.value.data?.length,
                      itemBuilder: (context, index, realIndex) {
                        String? imageUrl = dashboardController
                            .slideBannerList.value.data?[index].image;
                        if (imageUrl != null) {
                          return ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: CachedNetworkImage(
                              width: double.infinity,
                              imageUrl: imageUrl,
                              fit: BoxFit.fill,
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
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
                const SizedBox(height: 14.0),
              ],
            ),
          ),
        ),
      );
    });
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
    DashboardController dashboardController = Get.put(DashboardController());
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
                Text(
                  context.tr('change_language'),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.black),
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    dashboardController.setSelectedLanguage(Language.khmer);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: AppStyle.horizontalPadding,
                    ),
                    decoration: BoxDecoration(
                      color: dashboardController.selectedLanguage.value ==
                              Language.khmer
                          ? const Color(0x617C7C7C)
                          : Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
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
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.black,
                                    fontFamily: AppFontFamily.khmerFontFamily,
                                  ),
                        ),
                        const Spacer(),
                        if (dashboardController.selectedLanguage.value ==
                            Language.khmer)
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
                ),
                GestureDetector(
                  onTap: () {
                    dashboardController.setSelectedLanguage(Language.english);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 12,
                      left: AppStyle.horizontalPadding,
                      right: AppStyle.horizontalPadding,
                    ),
                    decoration: BoxDecoration(
                      color: dashboardController.selectedLanguage.value ==
                              Language.english
                          ? const Color(0x617C7C7C)
                          : Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
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
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.black,
                                    fontFamily: AppFontFamily.englishFontFamily,
                                  ),
                        ),
                        const Spacer(),
                        if (dashboardController.selectedLanguage.value ==
                            Language.english)
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
                      context.pop();

                      switch (dashboardController.selectedLanguage.value) {
                        case Language.khmer:
                          context.setLocale(const Locale('km', 'KH'));
                          break;
                        case Language.english:
                          context.setLocale(const Locale('en', 'US'));
                          break;
                      }
                    },
                    title: context.tr('continue'),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _logOutUser({required VoidCallback action}) async {
    DashboardController controller = Get.put(DashboardController());
    await controller.logOut();
    action.call();
  }
}
