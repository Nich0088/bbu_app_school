import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_app/src/common/base_get_x_controller.dart';
import 'package:school_app/src/common/model/custom_drop_down_menu_item.dart';
import 'package:school_app/src/core/auth/login/controller/login_controller.dart';
import 'package:school_app/src/modules/create_user_with_branch/model/create_user_work_in_branch_result.dart';
import 'package:school_app/src/modules/create_user_with_branch/model/university_branch_result.dart';

import '../../../common/api_endpoint.dart';
import '../../../common/helpers/local_storage.dart';
import '../../../core/auth/login/model/authorize_token_result.dart';

class CreateUserWithBranchController extends BaseGetXController {
  final LoginController _loginController = Get.put(LoginController());
  var universityBranchDropDownItemList = <CustomDropDownMenuItem>[].obs;
  var universityBranchTextEditingController = TextEditingController().obs;
  var idInBranchTextEditingController = TextEditingController().obs;
  var isInvalidIdInBranch = false.obs;
  var invalidIdInBranchDescription = "".obs;
  UniversityBranchData? _selectedUniversityBranch;
  UniversityBranchResult? _universityBranchResult;
  CreateUserWorkInBranchResult? createUserWorkInBranchResult;

  @override
  void onInit() async {
    await _getUniversityBranch();
    super.onInit();
  }

  void resetIdInBranchError() {
    invalidIdInBranchDescription.value = "";
    isInvalidIdInBranch.value = false;
  }

  void setSelectedUniversityBranch(
      CustomDropDownMenuItem selectedUniversityBranchDropDownItem) {
    int universityBranchDataListLength =
        _universityBranchResult?.universityBranchData?.length ?? 0;

    for (int index = 0; index < universityBranchDataListLength; index++) {
      if (_universityBranchResult?.universityBranchData?[index].branchId ==
          selectedUniversityBranchDropDownItem.id) {
        _selectedUniversityBranch =
            _universityBranchResult?.universityBranchData?[index];
        debugPrint(jsonEncode(_selectedUniversityBranch));
        break;
      }
    }
  }

  Future<void> saveUser({required VoidCallback onSuccess}) async {
    String urlString =
        ApiEndpoint.appBaseUrl9 + ApiEndpoint.payrollUserWorkInBranch;
    debugPrint(urlString);
    var url = Uri.parse(urlString);
    if (_selectedUniversityBranch == null) return;

    String? authorizeTokenData =
        await LocalStorage.getStringValue(key: LocalStorage.authorizeTokenData);

    if (authorizeTokenData == null) return;

    var authorizeTokenResult =
        AuthorizeTokenData.fromJson(jsonDecode(authorizeTokenData));

    await LocalStorage.storeData(
      key: LocalStorage.universityBranchData,
      value: jsonEncode(_selectedUniversityBranch?.toJson()),
    );

    setLoadingState(true);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${authorizeTokenResult.token}",
      },
      body: jsonEncode({
        "userId": _loginController.loginResult?.data?.id,
        "branchid": _selectedUniversityBranch?.branchId,
        "usertype_id": _loginController.selectedUserType?.id,
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

    createUserWorkInBranchResult =
        CreateUserWorkInBranchResult.fromJson(jsonDecode(response.body));

    if (createUserWorkInBranchResult?.code == 200) {
      onSuccess.call();
    } else if (createUserWorkInBranchResult?.createUserWorkInBranchData
            is String &&
        createUserWorkInBranchResult?.createUserWorkInBranchData
                .toString()
                .toLowerCase() ==
            'data already exists'.toLowerCase()) {
      onSuccess.call();
    } else {
      appDialogHelper?.showErrorDialog(
        errorMessage: createUserWorkInBranchResult?.message ?? '',
        errorCode: '${createUserWorkInBranchResult?.code}',
      );
    }
  }

  Future<void> _getUniversityBranch() async {
    String urlString = ApiEndpoint.appBaseUrl9 + ApiEndpoint.payrollBranch;
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
    debugPrint(response.body);

    if (response.body.isEmpty) {
      appDialogHelper?.showErrorDialog(
        errorMessage: 'something when wrong',
        errorCode: '',
      );
      return;
    }

    _universityBranchResult =
        UniversityBranchResult.fromJson(jsonDecode(response.body));

    if (_universityBranchResult?.code != 200) {
      appDialogHelper?.showErrorDialog(
        errorMessage: _universityBranchResult?.message ?? '',
        errorCode: '${_universityBranchResult?.code}',
      );
      return;
    }

    universityBranchDropDownItemList.value =
        _generateUniversityList(_universityBranchResult?.universityBranchData);
  }

  List<CustomDropDownMenuItem> _generateUniversityList(
      List<UniversityBranchData>? universityBranchDataList) {
    if (universityBranchDataList == null) return [];

    List<CustomDropDownMenuItem> userTypeCustomDropDownMenuItemList = [];

    for (int index = 0; index < universityBranchDataList.length; index++) {
      userTypeCustomDropDownMenuItemList.add(
        CustomDropDownMenuItem(
            value: universityBranchDataList[index].branchNameEn ?? '',
            id: universityBranchDataList[index].branchId ?? index,
            title: universityBranchDataList[index].branchNameEn ?? ''),
      );
    }

    return userTypeCustomDropDownMenuItemList;
  }
}
