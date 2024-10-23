import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_app/src/common/helpers/app_dialog_helper.dart';

import '../../../../common/api_endpoint.dart';
import '../../../../common/helpers/local_storage.dart';
import '../model/login_result.dart';

class LoginController extends GetxController {
  static const int _usernameMaxLength = 4;
  static const int _passwordMaxLength = 4;

  AppDialogHelper? _appDialogHelper;
  var usernameTextEditingController = TextEditingController().obs;
  var passwordTextEditingController = TextEditingController().obs;
  var isInvalidUsername = false.obs;
  var isInvalidPassword = false.obs;
  var invalidUsernameDescription = "".obs;
  var invalidPasswordDescription = "".obs;
  var isHidePassword = true.obs;
  var isShowLoading = false;

  void register(BuildContext context) {
    _appDialogHelper = AppDialogHelper(context: context);
  }

  void changePasswordVisibilityState() {
    isHidePassword.value = !isHidePassword.value;
  }

  void resetUsernameError() {
    invalidUsernameDescription.value = "";
    isInvalidUsername.value = false;
  }

  void resetPasswordError() {
    invalidPasswordDescription.value = "";
    isInvalidPassword.value = false;
  }

  Future<void> loginUser() async {
    if (usernameTextEditingController.value.text.length < _usernameMaxLength) {
      invalidUsernameDescription.value = "Please enter username";
      isInvalidUsername.value = true;
    }

    if (passwordTextEditingController.value.text.length < _passwordMaxLength) {
      invalidPasswordDescription.value = "Please enter password";
      isInvalidPassword.value = true;
    }

    if (isInvalidUsername.value == true || isInvalidPassword.value == true) {
      return;
    }

    String urlString =
        ApiEndpoint.loginBaseUrl + ApiEndpoint.appHelperAuthorizeLogin;
    var url = Uri.parse(urlString);
    _setLoadingState(true);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "username": usernameTextEditingController.value.text,
        "password": passwordTextEditingController.value.text,
      }),
    );
    _setLoadingState(false);
    // var loginResult = LoginResult.fromJson(json)
    //
    // if (response.statusCode == 200) {
    //   //
    // } else {
    //   _appDialogHelper?.showErrorDialog(errorMessage: response.body., errorCode: errorCode)
    // }
  }

  void _setLoadingState(bool isLoading) {
    isShowLoading = isLoading;
    update();
  }
}
