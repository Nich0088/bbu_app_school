import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'helpers/app_dialog_helper.dart';

class BaseGetXController extends GetxController {
  var isShowLoading = false;
  AppDialogHelper? appDialogHelper;

  void register(BuildContext context) {
    appDialogHelper = AppDialogHelper(context: context);
  }

  void setLoadingState(bool isLoading) {
    isShowLoading = isLoading;
    update();
  }
}
