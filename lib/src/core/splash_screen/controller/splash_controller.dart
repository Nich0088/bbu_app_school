import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:school_app/src/common/helpers/local_storage.dart';

class SplashController extends GetxController {
  Future<void> determineRoute(
      {required VoidCallback actionOnTokenExist,
      required VoidCallback actionOnTokenNotExist}) async {
    String? token =
        await LocalStorage.getStringValue(key: LocalStorage.tokenKey);

    if (token != null) {
      actionOnTokenExist.call();
    } else {
      actionOnTokenNotExist.call();
    }
  }
}
