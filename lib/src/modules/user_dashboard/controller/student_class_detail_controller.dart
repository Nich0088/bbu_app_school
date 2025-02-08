import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_app/src/common/base_get_x_controller.dart';
import 'package:school_app/src/modules/user_dashboard/model/class_schedule_subject_result.dart';

import '../../../common/api_endpoint.dart';
import '../../../common/helpers/local_storage.dart';
import '../../create_user_with_branch/model/university_branch_result.dart';

class StudentClassDetailController extends BaseGetXController {
  var classScheduleSubjectResult = ClassScheduleSubjectResult().obs;

  Future<void> getClassScheduleList({
    String? scheduleId,
    String? studentId,
  }) async {
    if (scheduleId == null ||
        scheduleId.isEmpty == true ||
        studentId == null ||
        studentId.isEmpty == true) return;

    String? universityBranchDataString = await LocalStorage.getStringValue(
        key: LocalStorage.universityBranchData);
    if (universityBranchDataString == null) return;
    var universityBranchData =
        UniversityBranchData.fromJson(jsonDecode(universityBranchDataString));

    if (universityBranchData.branchId == null ||
        universityBranchData.shortName == null) return;

    String urlString =
        '${ApiEndpoint.webBaseUrl}${ApiEndpoint.classSubjectList}';
    debugPrint(urlString);

    var url = Uri.parse(urlString);
    setLoadingState(true);

    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "branchId": universityBranchData.branchId?.toString(),
        "branchShortName": universityBranchData.shortName,
        "scheduleId": scheduleId,
        "studentId": studentId,
      }),
    );
    debugPrint('Grogu --> status code =  ${response.statusCode}');
    debugPrint('Grogu --> body = ${response.body}');
    setLoadingState(false);

    if (response.body.isEmpty) return;

    classScheduleSubjectResult.value =
        ClassScheduleSubjectResult.fromJson(jsonDecode(response.body));

    if (response.statusCode != 200) {
      appDialogHelper?.showErrorDialog(
        errorMessage:
            classScheduleSubjectResult.value.message ?? 'something when wrong',
        errorCode: classScheduleSubjectResult.value.code ?? '',
      );
    }
  }
}
