import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:school_app/src/common/helpers/local_storage.dart';
import 'package:school_app/src/core/auth/login/model/login_result.dart';
import 'package:school_app/src/modules/dashboard/models/certificate_format_item.dart';
import 'package:school_app/src/modules/dashboard/models/home_grid_item.dart';
import 'package:school_app/src/modules/dashboard/models/home_grid_item_type.dart';
import 'package:school_app/src/modules/dashboard/models/language.dart';
import 'package:school_app/src/modules/dashboard/models/message_item.dart';
import 'package:school_app/src/modules/dashboard/models/slide_banner.dart';

import '../../../common/api_endpoint.dart';
import '../../../common/helpers/app_dialog_helper.dart';

class DashboardController extends GetxController {
  @factoryMethod
  static init() => Get.put(DashboardController());

  List<HomeGridItem> get homeGridItemList => [
        HomeGridItem(
          0,
          "For Enrollment",
          "assets/dashboard/enrollment.png",
          HomeGridItemType.forEnrollment,
        ),
        HomeGridItem(
          1,
          "Campus",
          "assets/dashboard/campus.png",
          HomeGridItemType.campus,
        ),
        HomeGridItem(
          2,
          "Check In",
          "assets/dashboard/checkIn.png",
          HomeGridItemType.checkIn,
        ),
        HomeGridItem(
          3,
          "Events",
          "assets/dashboard/events.png",
          HomeGridItemType.event,
        ),
        HomeGridItem(
          4,
          "Location",
          "assets/dashboard/location.png",
          HomeGridItemType.location,
        ),
        // HomeGridItem(
        //   5,
        //   "Attendant",
        //   "assets/dashboard/attendance.png",
        //   HomeGridItemType.attendant,
        // ),
        HomeGridItem(
          6,
          "Contact",
          "assets/dashboard/contact.png",
          HomeGridItemType.contact,
        ),
        HomeGridItem(
          7,
          "Calendar",
          "assets/dashboard/calendar.png",
          HomeGridItemType.calendar,
        ),
        HomeGridItem(
          8,
          "Billing",
          "assets/dashboard/billing.png",
          HomeGridItemType.billing,
        ),
        HomeGridItem(
          11,
          "Study",
          "assets/dashboard/study.png",
          HomeGridItemType.study,
        ),
        HomeGridItem(
          9,
          "Video",
          "assets/dashboard/video.png",
          HomeGridItemType.video,
        ),
        HomeGridItem(
          10,
          "About Us",
          "assets/dashboard/aboutUs.png",
          HomeGridItemType.aboutUs,
        ),
        HomeGridItem(
          12,
          "Apply",
          "assets/dashboard/apply.png",
          HomeGridItemType.apply,
        ),
        HomeGridItem(
          13,
          "Scholarship",
          "assets/dashboard/scholarship.png",
          HomeGridItemType.scholarship,
        ),
        HomeGridItem(
          14,
          "FAQ",
          "assets/dashboard/faq.png",
          HomeGridItemType.faq,
        ),
      ];

  List<CertificateFormatItem> get certificateFormatList => [
        CertificateFormatItem(
          id: 0,
          title: "Associate's Degree",
          image: "assets/dashboard/Associate.png",
          imageUrl:
              "https://www.bbu.edu.kh/ckfinder/userfiles/images/Certificat/Associate%20of%20IT.jpg",
        ),
        CertificateFormatItem(
          id: 1,
          title: "Bachelor's Degree",
          image: "assets/dashboard/Associate.png",
          imageUrl:
              "https://www.bbu.edu.kh/ckfinder/userfiles/images/Certificat/Bachelor%20of%20IT.jpg",
        ),
        CertificateFormatItem(
          id: 2,
          title: "Master's Degree",
          image: "assets/dashboard/Associate.png",
          imageUrl:
              "https://www.bbu.edu.kh/ckfinder/userfiles/images/Certificat/Master%20IT.jpg",
        ),
        CertificateFormatItem(
          id: 3,
          title: "Doctoral Degree",
          image: "assets/dashboard/doctoral.png",
          imageUrl:
              "https://www.bbu.edu.kh/ckfinder/userfiles/images/Certificat/Master%20IT.jpg",
        ),
      ];

  List<MessageItem> get messageList => [
        MessageItem(
          id: 0,
          title: "Chairman",
          subTitle: "H.E.Dr. In Viracheat",
          image: "assets/dashboard/chairman.png",
        ),
        MessageItem(
          id: 1,
          title: "President",
          subTitle: "Assoc. Prof. Diep Seiha",
          image: "assets/dashboard/president.png",
        )
      ];

  var selectedLanguage = Language.english.obs;
  var slideBannerList = SlideBanner().obs;
  var userProfileData = LoginResultData().obs;
  var isShowLoading = false;
  AppDialogHelper? _appDialogHelper;

  @override
  void onInit() async {
    super.onInit();
    await _getBannerList();
    await _getUserProfileData();
  }

  void register(BuildContext context) {
    _appDialogHelper = AppDialogHelper(context: context);
  }

  void setSelectedLanguage(Language language) {
    selectedLanguage.value = language;
  }

  Future<void> _getBannerList() async {
    String urlString = ApiEndpoint.unAuthorizeBastUrl + ApiEndpoint.bannerList;
    debugPrint("$urlString");
    var url = Uri.parse(urlString);
    // _setLoadingState(true);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      slideBannerList.value = SlideBanner.fromJson(jsonDecode(response.body));
    } else {
      _appDialogHelper?.showErrorDialog(
        errorMessage: 'something when wrong',
        errorCode: '',
      );
    }
    _setLoadingState(false);
  }

  Future<void> logOut() async {
    await LocalStorage.clearLocalData();
  }

  Future<void> _getUserProfileData() async {
    String? userProfileDataString =
        await LocalStorage.getStringValue(key: LocalStorage.loginResultData);

    if (userProfileDataString == null) return;

    userProfileData.value =
        LoginResultData.fromJson(jsonDecode(userProfileDataString));
  }

  void _setLoadingState(bool isLoading) {
    isShowLoading = isLoading;
    update();
  }
}
