import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:school_app/src/common/base_get_x_controller.dart';

class ChangePasswordController extends BaseGetXController {
  var currentPasswordTextEditingController = TextEditingController().obs;
  var isInvalidCurrentPassword = false.obs;
  var invalidCurrentPasswordDescription = "".obs;
  var isHideCurrentPassword = true.obs;
  var newPasswordTextEditingController = TextEditingController().obs;
  var isInvalidNewPassword = false.obs;
  var invalidNewPasswordDescription = "".obs;
  var isHideNewPassword = true.obs;
  var confirmNewPasswordTextEditingController = TextEditingController().obs;
  var isInvalidConfirmNewPassword = false.obs;
  var invalidConfirmNewPasswordDescription = "".obs;
  var isHideConfirmNewPassword = true.obs;

  void changeCurrentPasswordVisibilityState() {
    isHideCurrentPassword.value = !isHideCurrentPassword.value;
  }

  void resetCurrentPasswordError() {
    invalidCurrentPasswordDescription.value = "";
    isInvalidCurrentPassword.value = false;
  }

  void changeNewPasswordVisibilityState() {
    isHideNewPassword.value = !isHideNewPassword.value;
  }

  void resetNewPasswordError() {
    invalidNewPasswordDescription.value = "";
    isInvalidNewPassword.value = false;
  }

  void changeConfirmNewPasswordVisibilityState() {
    isHideConfirmNewPassword.value = !isHideConfirmNewPassword.value;
  }

  void resetConfirmNewPasswordError() {
    invalidConfirmNewPasswordDescription.value = "";
    isInvalidConfirmNewPassword.value = false;
  }
}
