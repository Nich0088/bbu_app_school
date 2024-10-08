import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

class LocationController extends GetxController {
  @factoryMethod
  static init() => Get.put(LocationController());
}
