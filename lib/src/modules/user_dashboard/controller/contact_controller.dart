import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

class ContactController extends GetxController {
  @factoryMethod
  static init() => Get.put(ContactController());

  List<ContactItem> get contactItemList => [
        ContactItem(
          id: 0,
          image: "assets/app_logo.png",
          title: "Phnom Penh Campus",
          phoneNumber: "023 987 700, 012 682...",
          subTitle: "subTitle",
        ),
        ContactItem(
          id: 1,
          image: "assets/app_logo.png",
          title: "Phnom Penh Campus",
          phoneNumber: "023 987 700, 012 682...",
          subTitle: "subTitle",
        ),
        // ContactItem(
        //   id: 1,
        //   image: "assets/dashboard/call.png",
        //   title: "title2",
        //   phoneNumber: "023 987 700, 012 682...",
        //   subTitle: "subTitle2",
        // ),
      ];
}

class ContactItem {
  final int id;
  final String image;
  final String title;
  final String subTitle;
  final String phoneNumber;

  ContactItem({
    required this.id,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.phoneNumber,
  });
}
