import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_app/src/common/base_get_x_controller.dart';
import 'package:school_app/src/core/auth/login/model/login_result.dart';

import '../../../../common/api_endpoint.dart';
import '../../../../common/helpers/local_storage.dart';
import '../../../../common/model/custom_drop_down_menu_item.dart';
import '../../../../modules/create_user_with_branch/model/user_type_result.dart';
import '../model/authorize_token_result.dart';

class LoginController extends BaseGetXController {
  static const int _emailMaxLength = 4;
  static const int _passwordMaxLength = 4;

  var userTypeDropDownItemList = <CustomDropDownMenuItem>[].obs;
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
  UserTypeData? selectedUserType;
  UserTypeResult? _userTypeResult;
  LoginResult? loginResult;

  @override
  void onInit() async {
    await _getUserType();
    super.onInit();
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

  void setSelectedUserType(
      CustomDropDownMenuItem selectedUserTypeDropDownItem) {
    int userTypeDataListLength = _userTypeResult?.userTypeData?.length ?? 0;

    for (int index = 0; index < userTypeDataListLength; index++) {
      if (_userTypeResult?.userTypeData?[index].id ==
          selectedUserTypeDropDownItem.id) {
        selectedUserType = _userTypeResult?.userTypeData?[index];
        debugPrint(jsonEncode(selectedUserType));
        break;
      }
    }
  }

  Future<void> loginUser(
      {required VoidCallback onSuccess, required String languageCode}) async {
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
        '${ApiEndpoint.appBaseUrl9}${ApiEndpoint.login}?languageRequest=$languageCode';

    String? authorizeTokenData =
        await LocalStorage.getStringValue(key: LocalStorage.authorizeTokenData);

    if (authorizeTokenData == null) return;

    var authorizeTokenResult =
        AuthorizeTokenData.fromJson(jsonDecode(authorizeTokenData));
    await LocalStorage.storeData(
      key: LocalStorage.userTypeData,
      value: jsonEncode(selectedUserType?.toJson()),
    );

    var url = Uri.parse(urlString);
    setLoadingState(true);
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
          "usertype": selectedUserType?.usertypeName,
          "ostype": Platform.operatingSystem,
          "tokenid": "string"
        },
      ),
    );
    setLoadingState(false);
    if(response.statusCode != 200){
      appDialogHelper?.showErrorDialog(
        errorMessage: "Your username and password incorrect!",
        errorCode: "401",
      );
      return;
    }
    debugPrint(response.body);
    loginResult = LoginResult.fromJson(jsonDecode(response.body));
    debugPrint(jsonEncode(loginResult));
    switch (response.statusCode) {
      case 200:
        if (loginResult?.data != null) {
          await LocalStorage.storeData(
            key: LocalStorage.loginResultData,
            value: jsonEncode(loginResult?.data?.toJson()),
          );
          onSuccess.call();
        }
        break;
      case 400:
        appDialogHelper?.showErrorDialog(
          errorMessage: 'Username or password is incorrect!',
          errorCode: '400',
        );
        break;
      case 401:
        appDialogHelper?.showErrorDialog(
          errorMessage: 'Unauthorized',
          errorCode: '401',
        );
        break;
      case 404:
        appDialogHelper?.showErrorDialog(
          errorMessage: 'Not Found',
          errorCode: '404',
        );
        break;
      case 409:
        appDialogHelper?.showErrorDialog(
          errorMessage: 'Duplicate data',
          errorCode: '409',
        );
        break;
      default:
        appDialogHelper?.showErrorDialog(
          errorMessage: 'Internal Server Error',
          errorCode: '500',
        );
        break;
    }
  }

  Future<void> _getUserType() async {
    String urlString = ApiEndpoint.appBaseUrl9 + ApiEndpoint.payrollUserType;
    debugPrint(urlString);
    var url = Uri.parse(urlString);
    setLoadingState(true);
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );
    setLoadingState(false);

    if (response.body.isEmpty) {
      appDialogHelper?.showErrorDialog(
        errorMessage: 'something when wrong',
        errorCode: '',
      );
      return;
    }

    _userTypeResult = UserTypeResult.fromJson(jsonDecode(response.body));

    if (_userTypeResult?.code != 200) {
      appDialogHelper?.showErrorDialog(
        errorMessage: _userTypeResult?.message ?? '',
        errorCode: '${_userTypeResult?.code}',
      );
      return;
    }

    userTypeDropDownItemList.value =
        _generateUserType(_userTypeResult?.userTypeData);
  }

  List<CustomDropDownMenuItem> _generateUserType(
      List<UserTypeData>? userTypeDataList) {
    if (userTypeDataList == null) return [];

    List<CustomDropDownMenuItem> userTypeCustomDropDownMenuItemList = [];

    for (int index = 0; index < userTypeDataList.length; index++) {
      userTypeCustomDropDownMenuItemList.add(
        CustomDropDownMenuItem(
            value: userTypeDataList[index].usertypeName ?? '',
            id: userTypeDataList[index].id ?? index,
            title: userTypeDataList[index].usertypeName ?? ''),
      );
    }

    return userTypeCustomDropDownMenuItemList;
  }
}
