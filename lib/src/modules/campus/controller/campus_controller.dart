import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_app/src/modules/campus/model/campuses.dart';
import '../../../common/api_endpoint.dart';
import '../../../common/helpers/app_dialog_helper.dart';

class CampusController extends GetxController {
  var campuses = Campuses().obs;
  var isShowLoading = false;
  AppDialogHelper? _appDialogHelper;

  @override
  void onInit() async {
    super.onInit();
    await _getCampuses();
  }

  void register(BuildContext context) {
    _appDialogHelper = AppDialogHelper(context: context);
  }

  Future<void> _getCampuses() async {
    String urlString =
        ApiEndpoint.unAuthorizeBastUrl + ApiEndpoint.viewCampuses;
    debugPrint("$urlString");
    var url = Uri.parse(urlString);
    _setLoadingState(true);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      campuses.value = Campuses.fromJson(jsonDecode(response.body));
    } else {
      _appDialogHelper?.showErrorDialog(
        errorMessage: 'something when wrong',
        errorCode: '',
      );
    }
    _setLoadingState(false);
  }

  void _setLoadingState(bool isLoading) {
    isShowLoading = isLoading;
    update();
  }
}
