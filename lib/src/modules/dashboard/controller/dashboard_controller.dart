import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

class DashboardController extends GetxController {
  @factoryMethod
  static init() => Get.put(DashboardController());
}
