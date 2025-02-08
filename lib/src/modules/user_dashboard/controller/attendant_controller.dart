import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_app/src/common/base_get_x_controller.dart';
import 'package:school_app/src/modules/user_dashboard/model/check_in_and_out_history_result.dart';
import 'package:school_app/src/modules/user_dashboard/model/check_in_or_out_result.dart';

import '../../../common/api_endpoint.dart';
import '../model/attendant_screen_data.dart';

class AttendantController extends BaseGetXController {
  var attendantScreenData = AttendantScreenData().obs;
  var checkInAndOutList = <CheckInAndOutHistoryData>[].obs;

  void setAttendantScreenData(AttendantScreenData? attendantScreenData) async {
    if (attendantScreenData != null) {
      this.attendantScreenData.value = attendantScreenData;
      await getCheckInAndOutHistory(
        studentId: attendantScreenData.studentId,
        scheduleId: attendantScreenData.classScheduleSubjectData?.scheduleID
            ?.toString(),
        subjId:
            attendantScreenData.classScheduleSubjectData?.subjID?.toString(),
      );
    }
  }

  Future<void> getCheckInAndOutHistory({
    String? studentId,
    String? scheduleId,
    String? subjId,
  }) async {
    if (studentId == null || scheduleId == null || subjId == null) {
      return;
    }

    String urlString =
        '${ApiEndpoint.webBaseUrl}${ApiEndpoint.checkInAndCheckOutHistoryList}';
    var requestBody = jsonEncode(
      {
        "scheduleId": scheduleId,
        "studentId": studentId,
        "subjectId": subjId,
      },
    );
    debugPrint(urlString);
    debugPrint(requestBody);
    var url = Uri.parse(urlString);
    setLoadingState(true);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: requestBody,
    );
    debugPrint('Grogu --> checkInAndCheckOutHistoryList => ${response.body}');
    setLoadingState(false);
    if (response.body.isEmpty) return;

    CheckInAndOutHistoryResult checkInAndOutHistoryResult =
        CheckInAndOutHistoryResult.fromJson(jsonDecode(response.body));

    if (response.statusCode != 200) {
      appDialogHelper?.showErrorDialog(
        errorMessage:
            checkInAndOutHistoryResult.message ?? 'something when wrong',
        errorCode: '',
      );
    }
    checkInAndOutList.value = _getCheckInAndOutHistoryDataList(
      checkInAndOutHistoryResult.checkInAndOutHistoryDataList,
    );
  }

  List<CheckInAndOutHistoryData> _getCheckInAndOutHistoryDataList(
      List<CheckInAndOutHistoryData>? checkInAndOutHistoryDataList) {
    if (checkInAndOutHistoryDataList == null) return [];
    if (checkInAndOutHistoryDataList.isEmpty) return [];

    List<CheckInAndOutHistoryData> checkInOrOutHistoryDataList = [];

    for (int i = 0; i < checkInAndOutHistoryDataList.length; i++) {
      checkInOrOutHistoryDataList.add(checkInAndOutHistoryDataList[i]);
      CheckInAndOutHistoryData? checkOutData =
          checkInAndOutHistoryDataList[i].checkOut;
      if (checkOutData != null) {
        checkInOrOutHistoryDataList.add(checkOutData);
      }
    }

    return checkInOrOutHistoryDataList;
  }

  Future<void> checkIn({
    String? studentId,
    String? scheduleId,
    String? subjId,
  }) async {
    if (studentId == null || scheduleId == null || subjId == null) {
      return;
    }
    Position? position = await getCurrentLocation();
    if (position == null) return;

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
          "scheduleId": scheduleId,
          "studentId": studentId,
          "subjectId": subjId,
          "latitude": position.latitude,
          "longitude": position.longitude,
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
        errorCode: checkInResult.code ?? '',
      );
    }
    if (checkInResult.code == '200') {
      appDialogHelper?.showSuccessDialog(
        message: 'You have successfully check in',
      );
    }
  }

  Future<void> checkOut({
    String? studentId,
    String? scheduleId,
    String? subjId,
    String? checkInId,
  }) async {
    if (studentId == null ||
        scheduleId == null ||
        subjId == null ||
        checkInId == null) {
      return;
    }
    Position? position = await getCurrentLocation();
    if (position == null) return;

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
          "scheduleId": scheduleId,
          "studentId": studentId,
          "subjectId": subjId,
          "latitude": position.latitude,
          "longitude": position.longitude,
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
        errorCode: checkInResult.code ?? '',
      );
    }
    if (checkInResult.code == '200') {
      appDialogHelper?.showSuccessDialog(
        message: 'You have successfully check out',
      );
    }
  }

  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint("Location services are disabled.");
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint("Location permissions are permanently denied.");
      return null;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return position;
  }
}
