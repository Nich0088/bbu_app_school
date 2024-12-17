import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_app/src/common/base_get_x_controller.dart';
import 'package:school_app/src/modules/attendant/model/check_in_and_out_history_result.dart';
import 'package:school_app/src/modules/dashboard/controller/dashboard_controller.dart';

import '../../../common/api_endpoint.dart';

class AttendantController extends BaseGetXController {
  var checkInAndOutHistoryResult = CheckInAndOutHistoryResult().obs;
  final DashboardController _dashboardController =
      Get.put(DashboardController());

  @override
  void onInit() async {
    await _getCheckInAndOutHistory();
    super.onInit();
  }

  Future<void> _getCheckInAndOutHistory() async {
    // String? studentId = _dashboardController.userProfileData.value.id;
    String? studentId = '98';

    if (studentId == null) return;

    String urlString =
        '${ApiEndpoint.appBaseUrl10}${ApiEndpoint.checkList}/$studentId';
    debugPrint("$urlString");
    var url = Uri.parse(urlString);
    setLoadingState(true);
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );
    debugPrint('Grogu --> ${response.body}');
    if (response.body.isEmpty) return;

    checkInAndOutHistoryResult.value =
        CheckInAndOutHistoryResult.fromJson(jsonDecode(response.body));

    setLoadingState(false);

    if (response.statusCode != 200) {
      appDialogHelper?.showErrorDialog(
        errorMessage:
            checkInAndOutHistoryResult.value.message ?? 'something when wrong',
        errorCode: '',
      );
    }
  }
}
