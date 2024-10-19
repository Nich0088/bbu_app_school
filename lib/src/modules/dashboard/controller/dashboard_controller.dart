import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:school_app/src/modules/dashboard/models/certificate_format_item.dart';
import 'package:school_app/src/modules/dashboard/models/home_grid_item.dart';
import 'package:school_app/src/modules/dashboard/models/home_grid_item_type.dart';
import 'package:school_app/src/modules/dashboard/models/language.dart';
import 'package:school_app/src/modules/dashboard/models/message_item.dart';

class DashboardController extends GetxController {
  @factoryMethod
  static init() => Get.put(DashboardController());

  List<HomeGridItem> get homeGridItemList => [
        HomeGridItem(
          0,
          "Events",
          "assets/dashboard/event.png",
          HomeGridItemType.event,
        ),
        HomeGridItem(
          1,
          "For Enrollment",
          "assets/dashboard/enrollment.png",
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
          "assets/dashboard/map.png",
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
          "assets/dashboard/scholarship.png",
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
        // HomeGridItem(
        //   11,
        //   "Attendant",
        //   "assets/dashboard/calendar.png",
        //   HomeGridItemType.attendant,
        // ),
      ];

  List<CertificateFormatItem> get certificateFormatList => [
        CertificateFormatItem(
          id: 0,
          title: "Associate's Degree",
          image: "assets/app_logo.png",
        ),
        CertificateFormatItem(
          id: 1,
          title: "Bachelor's Degree",
          image: "assets/app_logo.png",
        ),
        CertificateFormatItem(
          id: 2,
          title: "Master's Degree",
          image: "assets/app_logo.png",
        ),
        CertificateFormatItem(
          id: 3,
          title: "Doctoral Degree",
          image: "assets/app_logo.png",
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
          image: "assets/dashboard/president.png",
        )
      ];

  List<String> get imageSlideList => [
        "https://queenstudios.shop/cdn/shop/products/iron_man_mk85_620x.jpg?v=1655287340",
        "https://static.wikia.nocookie.net/marvelcinematicuniverse/images/2/22/Thor_in_LoveAndThunder_Poster.jpg/revision/latest/scale-to-width-down/1200?cb=20231021012616",
        "https://cf-images.us-east-1.prod.boltdns.net/v1/static/5359769168001/0a823cb0-01a9-4835-a348-c64187783ccb/d37cb96c-805c-4aa2-9f2f-e62d9eb814c7/1280x720/match/image.jpg",
        "https://cdn.mos.cms.futurecdn.net/29pFDaXVUj4Kb8PkUqu6uJ.jpg",
        "https://i.ytimg.com/vi/iWbuLClZpRg/maxresdefault.jpg",
      ];

  var selectedLanguage = Language.english.obs;

  void setSelectedLanguage(Language language) {
    selectedLanguage.value = language;
  }
}
