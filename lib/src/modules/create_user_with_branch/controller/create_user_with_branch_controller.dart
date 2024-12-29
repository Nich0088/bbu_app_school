import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_app/src/common/base_get_x_controller.dart';
import 'package:school_app/src/common/model/custom_drop_down_menu_item.dart';
import 'package:school_app/src/modules/create_user_with_branch/model/university_branch_result.dart';
import 'package:school_app/src/modules/create_user_with_branch/model/user_type_result.dart';

import '../../../common/api_endpoint.dart';

class CreateUserWithBranchController extends BaseGetXController {
  var userTypeDropDownItemList = <CustomDropDownMenuItem>[].obs;
  var universityBranchDropDownItemList = <CustomDropDownMenuItem>[].obs;
  var selectedUniversityBranchId = (-1).obs;
  var userTypeTextEditingController = TextEditingController().obs;
  var universityBranchTextEditingController = TextEditingController().obs;
  var idInBranchTextEditingController = TextEditingController().obs;

  @override
  void onInit() async {
    await _getUserType();
    await _getUniversityBranch();
    super.onInit();
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

    UserTypeResult userTypeResult =
        UserTypeResult.fromJson(jsonDecode(response.body));

    if (userTypeResult.code != 200) {
      appDialogHelper?.showErrorDialog(
        errorMessage: userTypeResult.message ?? '',
        errorCode: '${userTypeResult.code}',
      );
      return;
    }

    userTypeDropDownItemList.value =
        _generateUserType(userTypeResult.userTypeData);
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

    if (response.body.isEmpty) {
      appDialogHelper?.showErrorDialog(
        errorMessage: 'something when wrong',
        errorCode: '',
      );
      return;
    }

    UniversityBranchResult universityBranchResult =
        UniversityBranchResult.fromJson(jsonDecode(response.body));

    if (universityBranchResult.code != 200) {
      appDialogHelper?.showErrorDialog(
        errorMessage: universityBranchResult.message ?? '',
        errorCode: '${universityBranchResult.code}',
      );
      return;
    }

    universityBranchDropDownItemList.value =
        _generateUniversityList(universityBranchResult.universityBranchData);
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
