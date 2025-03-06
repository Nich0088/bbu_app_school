import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:school_app/src/common/helpers/local_storage.dart';
import 'package:school_app/src/core/auth/login/model/login_result.dart';
import 'package:school_app/src/modules/dashboard/models/certificate_format_item.dart';
import 'package:school_app/src/modules/dashboard/models/home_grid_item.dart';
import 'package:school_app/src/modules/dashboard/models/language.dart';
import 'package:school_app/src/modules/dashboard/models/message_item.dart';
import 'package:school_app/src/modules/dashboard/models/slide_banner.dart';
import 'package:school_app/src/modules/dashboard/models/user_type.dart';

import '../../../common/api_endpoint.dart';
import '../../../common/helpers/app_dialog_helper.dart';
import '../../create_user_with_branch/model/user_type_result.dart';
import '../models/home_grid_item_type.dart';

class DashboardController extends GetxController {
  @factoryMethod
  static init() => Get.put(DashboardController());

  final List<HomeGridItem> _studentAndTeacherHomeGridItemList = [
    HomeGridItem(
      0,
      'for_Enrollment',
      "assets/dashboard/enrollment.png",
      HomeGridItemType.forEnrollment,
    ),
    HomeGridItem(
      1,
      "campus",
      "assets/dashboard/campus.png",
      HomeGridItemType.campus,
    ),
    HomeGridItem(
      2,
      "check_in",
      "assets/dashboard/checkIn.png",
      HomeGridItemType.checkIn,
    ),
    HomeGridItem(
      3,
      "events",
      "assets/dashboard/events.png",
      HomeGridItemType.event,
    ),
    HomeGridItem(
      4,
      "location",
      "assets/dashboard/location.png",
      HomeGridItemType.location,
    ),
    HomeGridItem(
      6,
      "contact",
      "assets/dashboard/contact.png",
      HomeGridItemType.contact,
    ),
    HomeGridItem(
      7,
      "calendar",
      "assets/dashboard/calendar.png",
      HomeGridItemType.calendar,
    ),
    HomeGridItem(
      8,
      "billing",
      "assets/dashboard/billing.png",
      HomeGridItemType.billing,
    ),
    HomeGridItem(
      11,
      "study",
      "assets/dashboard/study.png",
      HomeGridItemType.study,
    ),
    HomeGridItem(
      9,
      "video",
      "assets/dashboard/video.png",
      HomeGridItemType.video,
    ),
    HomeGridItem(
      10,
      "about_us",
      "assets/dashboard/aboutUs.png",
      HomeGridItemType.aboutUs,
    ),
    HomeGridItem(
      12,
      "apply",
      "assets/dashboard/apply.png",
      HomeGridItemType.apply,
    ),
    HomeGridItem(
      13,
      "scholarship",
      "assets/dashboard/scholarship.png",
      HomeGridItemType.scholarship,
    ),
    HomeGridItem(
      14,
      "fag",
      "assets/dashboard/faq.png",
      HomeGridItemType.faq,
    ),
  ];

  final List<HomeGridItem> _guestHomeGridItemList = [
    HomeGridItem(
      0,
      "for_enrollment",
      "assets/dashboard/enrollment.png",
      HomeGridItemType.forEnrollment,
    ),
    HomeGridItem(
      4,
      "location",
      "assets/dashboard/location.png",
      HomeGridItemType.location,
    ),
    HomeGridItem(
      9,
      "video",
      "assets/dashboard/video.png",
      HomeGridItemType.video,
    ),
    HomeGridItem(
      1,
      "campus",
      "assets/dashboard/campus.png",
      HomeGridItemType.campus,
    ),
    HomeGridItem(
      6,
      "contact",
      "assets/dashboard/contact.png",
      HomeGridItemType.contact,
    ),
    HomeGridItem(
      10,
      "about_us",
      "assets/dashboard/aboutUs.png",
      HomeGridItemType.aboutUs,
    ),
    HomeGridItem(
      3,
      "events",
      "assets/dashboard/events.png",
      HomeGridItemType.event,
    ),
    HomeGridItem(
      7,
      "calendar",
      "assets/dashboard/calendar.png",
      HomeGridItemType.calendar,
    ),
    HomeGridItem(
      12,
      "apply",
      "assets/dashboard/apply.png",
      HomeGridItemType.apply,
    ),
    HomeGridItem(
      13,
      "scholarship",
      "assets/dashboard/scholarship.png",
      HomeGridItemType.scholarship,
    ),
    HomeGridItem(
      14,
      "faq",
      "assets/dashboard/faq.png",
      HomeGridItemType.faq,
    ),
  ];

  List<CertificateFormatItem> get certificateFormatList => [
        CertificateFormatItem(
          id: 0,
          title: "associates_degree",
          image: "assets/dashboard/Associate.png",
          imageUrl:
              "https://www.bbu.edu.kh/ckfinder/userfiles/images/Certificat/Associate%20of%20IT.jpg",
        ),
        CertificateFormatItem(
          id: 1,
          title: "bachelors_degree",
          image: "assets/dashboard/Associate.png",
          imageUrl:
              "https://www.bbu.edu.kh/ckfinder/userfiles/images/Certificat/Bachelor%20of%20IT.jpg",
        ),
        CertificateFormatItem(
          id: 2,
          title: "masters_degree",
          image: "assets/dashboard/Associate.png",
          imageUrl:
              "https://www.bbu.edu.kh/ckfinder/userfiles/images/Certificat/Master%20IT.jpg",
        ),
        CertificateFormatItem(
          id: 3,
          title: "doctoral_degree",
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

  var homeGridItemList = <HomeGridItem>[].obs;
  var selectedLanguage = Language.english.obs;
  var slideBannerList = SlideBanner().obs;
  var userProfileData = LoginResultData().obs;
  var userTypeData = UserTypeData().obs;
  var isShowLoading = false;
  AppDialogHelper? _appDialogHelper;

  @override
  void onInit() async {
    super.onInit();
    await _getBannerList();
    await _getUserProfileData();

    String? userTypeDataString =
        await LocalStorage.getStringValue(key: LocalStorage.userTypeData);
    if (userTypeDataString == null) return;
    userTypeData.value = UserTypeData.fromJson(jsonDecode(userTypeDataString));
  }

  void register(BuildContext context) {
    _appDialogHelper = AppDialogHelper(context: context);
  }

  void initializeHomeGridItemList(UserType? userType) {
    homeGridItemList.value = userType == UserType.loggedInUser
        ? _studentAndTeacherHomeGridItemList
        : _guestHomeGridItemList;
  }

  void setSelectedLanguage(Language language) {
    selectedLanguage.value = language;
  }

  Future<void> _getBannerList() async {
    String urlString = ApiEndpoint.unAuthorizeBastUrl + ApiEndpoint.bannerList;
    debugPrint(urlString);
    var url = Uri.parse(urlString);
    _setLoadingState(true);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );
    _setLoadingState(false);
    if (response.statusCode == 200) {
      slideBannerList.value = SlideBanner.fromJson(jsonDecode(response.body));
    } else {
      _appDialogHelper?.showErrorDialog(
        errorMessage: 'something when wrong',
        errorCode: '',
      );
    }
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
