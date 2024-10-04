import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:school_app/src/modules/user_dashboard/model/study_item.dart';

class UserDashboardController extends GetxController {
  @factoryMethod
  static init() => Get.put(UserDashboardController());

  List<StudyItem> get studyItemList => [
        StudyItem(
          id: 0,
          title: "Branch name in English",
          label: "Phnom Penh Campus",
        ),
        StudyItem(
          id: 1,
          title: "Branch name in Khmer",
          label: "សាខាភ្នំពេញ",
        ),
        StudyItem(
          id: 2,
          title: "Faculty name in English",
          label: "Science in Technology",
        ),
        StudyItem(
          id: 3,
          title: "Faculty name in Khmer",
          label: "វិទ្យាសាស្រ្តនឹងបច្ចេកវិទ្យា",
        ),
        StudyItem(
          id: 4,
          title: "Field in English",
          label: "Information Technology (Profession)",
        ),
        StudyItem(
          id: 5,
          title: "Field in Khmer",
          label: "បច្ចេកវិទ្យាព័ត៏មាន​ (កម្រិតវិជ្ជាជីវះ)",
        ),
        StudyItem(
          id: 6,
          title: "Degree in English",
          label: "Bachelor",
        ),
        StudyItem(
          id: 7,
          title: "Degree in Khmer",
          label: "បរិញ្ញាប័ត្រ",
        ),
      ];
}
