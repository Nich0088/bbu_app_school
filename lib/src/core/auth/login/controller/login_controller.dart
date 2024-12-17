import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_app/src/common/helpers/app_dialog_helper.dart';
import 'package:school_app/src/core/auth/login/model/login_result.dart';

import '../../../../common/api_endpoint.dart';
import '../../../../common/helpers/local_storage.dart';
import '../../../../common/model/custom_drop_down_menu_item.dart';
import '../model/authorize_token_result.dart';

class LoginController extends GetxController {
  static const int _emailMaxLength = 4;
  static const int _passwordMaxLength = 4;

  AppDialogHelper? _appDialogHelper;
  var emailTextEditingController = TextEditingController().obs;
  var passwordTextEditingController = TextEditingController().obs;
  var userTypeTextEditingController = TextEditingController().obs;
  var isInvalidEmail = false.obs;
  var isInvalidPassword = false.obs;
  var isInvalidUserType = false.obs;
  var invalidEmailDescription = "".obs;
  var invalidPasswordDescription = "".obs;
  var invalidUserTypeDescription = "".obs;
  var isHidePassword = true.obs;
  var isShowLoading = false;
  CustomDropDownMenuItem? selectedUserType;

  List<CustomDropDownMenuItem> get userTypeList => [
        CustomDropDownMenuItem(id: 0, title: 'Student', value: 'student'),
        CustomDropDownMenuItem(id: 1, title: 'Teacher', value: 'teacher'),
      ];

  void register(BuildContext context) {
    _appDialogHelper = AppDialogHelper(context: context);
  }

  void changePasswordVisibilityState() {
    isHidePassword.value = !isHidePassword.value;
  }

  void resetUsernameError() {
    invalidEmailDescription.value = "";
    isInvalidEmail.value = false;
  }

  void resetPasswordError() {
    invalidPasswordDescription.value = "";
    isInvalidPassword.value = false;
  }

  void resetUserTypeError() {
    invalidUserTypeDescription.value = "";
    isInvalidUserType.value = false;
  }

  Future<void> getApiToken() async {
    String urlString = ApiEndpoint.appBaseUrl9 + ApiEndpoint.authorizeToken;
    var url = Uri.parse(urlString);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "username": 'mich',
        "password": '1234',
      }),
    );
    var authorizeTokenResult =
        AuthorizeTokenResult.fromJson(jsonDecode(response.body));
    if (authorizeTokenResult.code == 200) {
      if (authorizeTokenResult.data?.token != null) {
        await LocalStorage.storeData(
          key: LocalStorage.authorizeTokenData,
          value: jsonEncode(authorizeTokenResult.data?.toJson()),
        );
      }
    }
  }

  Future<void> loginUser({required VoidCallback onSuccess}) async {
    if (emailTextEditingController.value.text.length < _emailMaxLength) {
      invalidEmailDescription.value = "Please enter username";
      isInvalidEmail.value = true;
    }

    if (passwordTextEditingController.value.text.length < _passwordMaxLength) {
      invalidPasswordDescription.value = "Please enter password";
      isInvalidPassword.value = true;
    }

    if (selectedUserType == null) {
      invalidUserTypeDescription.value = "Please select user type";
      isInvalidUserType.value = true;
    }

    if (isInvalidEmail.value == true ||
        isInvalidPassword.value == true ||
        isInvalidUserType.value == true) {
      return;
    }

    String urlString =
        '${ApiEndpoint.appBaseUrl9}${ApiEndpoint.login}?languageRequest=km';

    _setLoadingState(true);

    String? authorizeTokenData =
        await LocalStorage.getStringValue(key: LocalStorage.authorizeTokenData);

    if (authorizeTokenData == null) {
      await getApiToken();
      authorizeTokenData = await LocalStorage.getStringValue(
        key: LocalStorage.authorizeTokenData,
      );
    }

    if (authorizeTokenData == null) return;

    var authorizeTokenResult =
        AuthorizeTokenData.fromJson(jsonDecode(authorizeTokenData));

    var url = Uri.parse(urlString);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${authorizeTokenResult.token}",
      },
      body: jsonEncode(
        {
          "email": emailTextEditingController.value.text,
          "password": passwordTextEditingController.value.text,
          "usertype": selectedUserType?.value,
          "ostype": Platform.operatingSystem,
          "tokenid": "string"
        },
      ),
    );
    _setLoadingState(false);
    LoginResult loginResult = LoginResult.fromJson(jsonDecode(response.body));
    debugPrint(jsonEncode(loginResult));
    switch (response.statusCode) {
      case 200:
        if (loginResult.data != null) {
          await LocalStorage.storeData(
            key: LocalStorage.userProfileData,
            value: jsonEncode(loginResult.data?.toJson()),
          );
          onSuccess.call();
        }
        break;
      case 400:
        _appDialogHelper?.showErrorDialog(
          errorMessage: 'Username or password is incorrect!',
          errorCode: '400',
        );
        break;
      case 401:
        _appDialogHelper?.showErrorDialog(
          errorMessage: 'Unauthorized',
          errorCode: '401',
        );
        break;
      case 404:
        _appDialogHelper?.showErrorDialog(
          errorMessage: 'Not Found',
          errorCode: '404',
        );
        break;
      case 409:
        _appDialogHelper?.showErrorDialog(
          errorMessage: 'Duplicate data',
          errorCode: '409',
        );
        break;
      default:
        _appDialogHelper?.showErrorDialog(
          errorMessage: 'Internal Server Error',
          errorCode: '500',
        );
        break;
    }
  }

  void _setLoadingState(bool isLoading) {
    isShowLoading = isLoading;
    update();
  }
}
