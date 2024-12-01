import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
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
          "Events",
          "assets/dashboard/events.png",
          HomeGridItemType.event,
        ),
        HomeGridItem(
          1,
          "For Enrollment",
          "assets/dashboard/enrollments.png",
          HomeGridItemType.forEnrollment,
        ),
        HomeGridItem(
          2,
          "Check In",
          "assets/dashboard/check_in.png",
          HomeGridItemType.checkIn,
        ),
        HomeGridItem(
          3,
          "Campus",
          "assets/dashboard/campus.png",
          HomeGridItemType.campus,
        ),
        HomeGridItem(
          4,
          "Location",
          "assets/dashboard/maps.png",
          HomeGridItemType.location,
        ),
        HomeGridItem(
          5,
          "Billing",
          "assets/dashboard/billing.png",
          HomeGridItemType.billing,
        ),
        HomeGridItem(
          6,
          "Scholarship",
          "assets/dashboard/scholarships.png",
          HomeGridItemType.scholarship,
        ),
        HomeGridItem(
          7,
          "About Us",
          "assets/dashboard/about.png",
          HomeGridItemType.aboutUs,
        ),
        HomeGridItem(
          8,
          "Study",
          "assets/dashboard/control.png",
          HomeGridItemType.study,
        ),
        HomeGridItem(
          9,
          "Attendant",
          "assets/dashboard/calendar.png",
          HomeGridItemType.attendant,
        ),
        HomeGridItem(
          10,
          "Contact",
          "assets/dashboard/call.png",
          HomeGridItemType.contact,
        ),
        HomeGridItem(
          11,
          "Video",
          "assets/dashboard/videos.png",
          HomeGridItemType.video,
        ),
        HomeGridItem(
          12,
          "Apply",
          "assets/dashboard/web-browser.png",
          HomeGridItemType.apply,
        ),
        HomeGridItem(
          13,
          "Calendar",
          "assets/dashboard/calendars.png",
          HomeGridItemType.calendar,
        ),
      ];

  List<CertificateFormatItem> get certificateFormatList => [
        CertificateFormatItem(
          id: 0,
          title: "Associate's Degree",
          image: "assets/app_logo.png",
          imageUrl:
              "https://www.bbu.edu.kh/ckfinder/userfiles/images/Certificat/Associate%20of%20IT.jpg",
        ),
        CertificateFormatItem(
          id: 1,
          title: "Bachelor's Degree",
          image: "assets/app_logo.png",
          imageUrl:
              "https://www.bbu.edu.kh/ckfinder/userfiles/images/Certificat/Bachelor%20of%20IT.jpg",
        ),
        CertificateFormatItem(
          id: 2,
          title: "Master's Degree",
          image: "assets/app_logo.png",
          imageUrl:
              "https://www.bbu.edu.kh/ckfinder/userfiles/images/Certificat/Master%20IT.jpg",
        ),
        CertificateFormatItem(
          id: 3,
          title: "Doctoral Degree",
          image: "assets/app_logo.png",
          imageUrl:
              "https://www.bbu.edu.kh/ckfinder/userfiles/images/Certificat/Master%20IT.jpg",
        ),
        // CertificateFormatItem(
        //   id: 4,
        //   title: "Diploma's Degree",
        //   image: "assets/app_logo.png",
        // ),
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
          image: "assets/dashboard/message_master.png",
        )
      ];

  var selectedLanguage = Language.english.obs;
  var slideBannerList = SlideBanner().obs;
  var isShowLoading = false;
  AppDialogHelper? _appDialogHelper;

  @override
  void onInit() async {
    super.onInit();
    await _getBannerList();
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
    _setLoadingState(true);
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

  void _setLoadingState(bool isLoading) {
    isShowLoading = isLoading;
    update();
  }
}
