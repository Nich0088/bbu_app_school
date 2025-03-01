import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_app/src/common/base_get_x_controller.dart';
import 'package:school_app/src/modules/create_user_with_branch/model/user_type_result.dart';

import '../../../common/api_endpoint.dart';
import '../../../common/helpers/local_storage.dart';
import '../../../core/auth/login/model/authorize_token_result.dart';
import '../../../core/auth/login/model/login_result.dart';

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

  Future<void> changeUserPassword({required String languageCode}) async {
    if (currentPasswordTextEditingController.value.text.isEmpty ||
        newPasswordTextEditingController.value.text.isEmpty ||
        confirmNewPasswordTextEditingController.value.text.isEmpty) return;

    String urlString =
        "${ApiEndpoint.appBaseUrl9}${ApiEndpoint.changePassword}?languageRequest=$languageCode";
    debugPrint(urlString);
    var url = Uri.parse(urlString);

    String? authorizeTokenData =
        await LocalStorage.getStringValue(key: LocalStorage.authorizeTokenData);

    if (authorizeTokenData == null) return;

    var authorizeTokenResult =
        AuthorizeTokenData.fromJson(jsonDecode(authorizeTokenData));

    String? userProfileDataString =
        await LocalStorage.getStringValue(key: LocalStorage.loginResultData);

    if (userProfileDataString == null) return;

    LoginResultData loginResultData =
        LoginResultData.fromJson(jsonDecode(userProfileDataString));

    String? userTypeDataString =
        await LocalStorage.getStringValue(key: LocalStorage.userTypeData);

    if (userTypeDataString == null) return;

    UserTypeData userTypeData =
        UserTypeData.fromJson(jsonDecode(userTypeDataString));

    setLoadingState(true);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${authorizeTokenResult.token}",
      },
      body: jsonEncode({
        "user_id": loginResultData.id,
        "currentPassword": currentPasswordTextEditingController.value.text,
        "newPassword": newPasswordTextEditingController.value.text,
        "confirmNewPassword":
            confirmNewPasswordTextEditingController.value.text,
        "usertype": userTypeData.usertypeName,
        "ostype": Platform.operatingSystem,
        "tokenid": "string"
      }),
    );
    setLoadingState(false);
    debugPrint(response.body);

    if (response.body.isEmpty) {
      appDialogHelper?.showErrorDialog(
        errorMessage: 'something when wrong',
        errorCode: '',
      );
      return;
    }

    var changePasswordResult = jsonDecode(response.body);

    if (response.statusCode == 200) {
      appDialogHelper?.showSuccessDialog(
          message: '${changePasswordResult["message"]}');
    } else {
      appDialogHelper?.showErrorDialog(
        errorMessage: '${changePasswordResult["message"]}',
        errorCode: '${changePasswordResult["code"]}',
      );
    }
  }
}
