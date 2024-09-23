import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:school_app/src/modules/dashboard/models/home_grid_item.dart';
import 'package:school_app/src/modules/dashboard/models/home_grid_item_type.dart';

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
      ];
}
