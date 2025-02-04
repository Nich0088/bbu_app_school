import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_app/src/common/base_get_x_controller.dart';
import 'package:school_app/src/modules/user_dashboard/model/check_in_and_out_history_result.dart';
import 'package:school_app/src/modules/user_dashboard/model/check_in_or_out_result.dart';

import '../../../common/api_endpoint.dart';
import '../model/attendant_screen_data.dart';

class AttendantController extends BaseGetXController {
  var checkInAndOutHistoryResult = CheckInAndOutHistoryResult().obs;
  var attendantScreenData = AttendantScreenData().obs;

  @override
  void onInit() async {
    await _getCheckInAndOutHistory();
    super.onInit();
  }

  void setAttendantScreenData(AttendantScreenData? attendantScreenData) async {
    if (attendantScreenData != null) {
      this.attendantScreenData.value = attendantScreenData;
      _getCheckInAndOutHistory();
    }
  }

  Future<void> _getCheckInAndOutHistory() async {
    if (attendantScreenData.value.studentId == null ||
        attendantScreenData.value.classScheduleSubjectData?.scheduleID ==
            null ||
        attendantScreenData.value.classScheduleSubjectData?.subjID == null) {
      return;
    }

    String urlString =
        '${ApiEndpoint.webBaseUrl}${ApiEndpoint.checkInAndCheckOutHistoryList}';
    debugPrint(urlString);
    var url = Uri.parse(urlString);
    setLoadingState(true);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          "scheduleId": attendantScreenData
              .value.classScheduleSubjectData?.scheduleID
              ?.toString(),
          "studentId": attendantScreenData.value.studentId,
          "subjectId": attendantScreenData
              .value.classScheduleSubjectData?.subjID
              ?.toString(),
        },
      ),
    );
    debugPrint('Grogu --> ${response.body}');
    setLoadingState(false);
    if (response.body.isEmpty) return;

    checkInAndOutHistoryResult.value =
        CheckInAndOutHistoryResult.fromJson(jsonDecode(response.body));

    if (response.statusCode != 200) {
      appDialogHelper?.showErrorDialog(
        errorMessage:
            checkInAndOutHistoryResult.value.message ?? 'something when wrong',
        errorCode: '',
      );
    }
  }

  Future<void> checkIn() async {
    String urlString =
        '${ApiEndpoint.webBaseUrl}${ApiEndpoint.classCheckInAndCheckOut}';
    debugPrint(urlString);
    var url = Uri.parse(urlString);
    setLoadingState(true);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          "scheduleId": attendantScreenData
              .value.classScheduleSubjectData?.scheduleID
              ?.toString(),
          "studentId": attendantScreenData.value.studentId,
          "subjectId": attendantScreenData
              .value.classScheduleSubjectData?.subjID
              ?.toString(),
          "latitude": "12.2323",
          "longitude": "34.3434",
          "id": 0,
        },
      ),
    );
    debugPrint('Grogu --> ${response.body}');
    setLoadingState(false);
    if (response.body.isEmpty) return;

    CheckInOrOutResult checkInResult =
        CheckInOrOutResult.fromJson(jsonDecode(response.body));

    if (response.statusCode != 200) {
      appDialogHelper?.showErrorDialog(
        errorMessage: checkInResult.message ?? 'something when wrong',
        errorCode: '',
      );
    }
    if (checkInResult.code == '200') {
      appDialogHelper?.showSuccessDialog(
          message: 'You have successfully check in');
    }
  }

  Future<void> checkOut(String checkInId) async {
    String urlString =
        '${ApiEndpoint.webBaseUrl}${ApiEndpoint.classCheckInAndCheckOut}';
    debugPrint(urlString);
    var url = Uri.parse(urlString);
    setLoadingState(true);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(
        {
          "scheduleId": attendantScreenData
              .value.classScheduleSubjectData?.scheduleID
              ?.toString(),
          "studentId": attendantScreenData.value.studentId,
          "subjectId": attendantScreenData
              .value.classScheduleSubjectData?.subjID
              ?.toString(),
          "latitude": "12.2323",
          "longitude": "34.3434",
          "id": checkInId,
        },
      ),
    );
    debugPrint('Grogu --> ${response.body}');
    setLoadingState(false);
    if (response.body.isEmpty) return;

    CheckInOrOutResult checkInResult =
        CheckInOrOutResult.fromJson(jsonDecode(response.body));

    if (response.statusCode != 200) {
      appDialogHelper?.showErrorDialog(
        errorMessage: checkInResult.message ?? 'something when wrong',
        errorCode: '',
      );
    }
    if (checkInResult.code == '200') {
      appDialogHelper?.showSuccessDialog(
          message: 'You have successfully check out');
    }
  }
}
