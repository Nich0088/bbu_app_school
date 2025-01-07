import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_app/src/common/base_get_x_controller.dart';
import 'package:school_app/src/core/auth/login/controller/login_controller.dart';
import 'package:school_app/src/core/auth/login/model/login_result.dart';
import 'package:school_app/src/modules/create_user_with_branch/model/university_branch_result.dart';
import 'package:school_app/src/modules/create_user_with_branch/model/user_type_result.dart';
import 'package:school_app/src/modules/user_dashboard/model/student_id_result.dart';
import 'package:school_app/src/modules/user_dashboard/model/student_profile_result.dart';
import 'package:school_app/src/modules/user_dashboard/model/student_score_result.dart';

import '../../../common/api_endpoint.dart';
import '../../../common/app_constant.dart';
import '../../../common/helpers/local_storage.dart';
import '../../../core/auth/login/model/authorize_token_result.dart';
import '../model/class_time_schedule_result.dart';
import '../model/study_item.dart';
import '../model/study_result_item.dart';

class UserDashboardController extends BaseGetXController {
  var classTimeScheduleResult = ClassTimeScheduleResult().obs;
  var studentIdList = <String>[].obs;
  var selectedStudentId = ''.obs;
  var studentProfileDataList = <StudyItem>[].obs;
  var studentScoreList = <StudentScoreItem>[].obs;

  LoginController loginController = Get.put(LoginController());

  @override
  void onInit() async {
    await _getStudentId();
    super.onInit();
  }

  Future<void> setSelectedStudentId(String studentId) async {
    if (selectedStudentId.value.toLowerCase() == studentId.toLowerCase()) {
      return;
    }

    selectedStudentId.value = studentId;
    debugPrint(studentId);

    await _getStudentProfile(studentId);
  }

  Future<void> getClassSchedule() async {
    String urlString =
        '${ApiEndpoint.appBaseUrl9}${ApiEndpoint.classTimeSchedule}/${AppConstant.mockBranch}/${AppConstant.mockScheduleId}/${AppConstant.mockScheduleStatus}';
    debugPrint("$urlString");

    String? authorizeTokenData =
        await LocalStorage.getStringValue(key: LocalStorage.authorizeTokenData);

    if (authorizeTokenData == null) return;

    var authorizeTokenResult =
        AuthorizeTokenData.fromJson(jsonDecode(authorizeTokenData));

    var url = Uri.parse(urlString);
    setLoadingState(true);

    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${authorizeTokenResult.token}",
      },
    );
    debugPrint('Grogu --> status code =  ${response.statusCode}');
    debugPrint('Grogu --> body = ${response.body}');
    setLoadingState(false);

    if (response.body.isEmpty) return;

    classTimeScheduleResult.value =
        ClassTimeScheduleResult.fromJson(jsonDecode(response.body));

    if (response.statusCode != 200) {
      appDialogHelper?.showErrorDialog(
        errorMessage:
            classTimeScheduleResult.value.message ?? 'something when wrong',
        errorCode: '',
      );
    }
  }

  Future<void> _getStudentId() async {
    String? loginResultDataString =
        await LocalStorage.getStringValue(key: LocalStorage.loginResultData);
    if (loginResultDataString == null) return;
    var loginResultData =
        LoginResultData.fromJson(jsonDecode(loginResultDataString));

    String? userTypeDataString =
        await LocalStorage.getStringValue(key: LocalStorage.userTypeData);
    if (userTypeDataString == null) return;
    var userTypeData = UserTypeData.fromJson(jsonDecode(userTypeDataString));

    String? universityBranchDataString = await LocalStorage.getStringValue(
        key: LocalStorage.universityBranchData);
    if (universityBranchDataString == null) return;
    var universityBranchData =
        UniversityBranchData.fromJson(jsonDecode(universityBranchDataString));

    String urlString =
        '${ApiEndpoint.appBaseUrl9}${ApiEndpoint.userWorkId}/${loginResultData.id}/${universityBranchData.shortName}/${userTypeData.id}';
    debugPrint("$urlString");

    String? authorizeTokenData =
        await LocalStorage.getStringValue(key: LocalStorage.authorizeTokenData);

    if (authorizeTokenData == null) return;

    var authorizeTokenResult =
        AuthorizeTokenData.fromJson(jsonDecode(authorizeTokenData));

    var url = Uri.parse(urlString);
    setLoadingState(true);

    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${authorizeTokenResult.token}",
      },
    );
    debugPrint('Grogu --> status code =  ${response.statusCode}');
    debugPrint('Grogu --> body = ${response.body}');
    setLoadingState(false);

    if (response.body.isEmpty) return;

    StudentIdResult studentIdResult =
        StudentIdResult.fromJson(jsonDecode(response.body));

    if (response.statusCode != 200) {
      appDialogHelper?.showErrorDialog(
        errorMessage: studentIdResult.message ?? 'something when wrong',
        errorCode: studentIdResult.code?.toString() ?? '',
      );
      return;
    }
    studentIdList.value = studentIdResult.data ?? [];
    if (studentIdList.value.isNotEmpty) {
      selectedStudentId.value = studentIdList.value.first;
      await _getStudentProfile(selectedStudentId.value);
    }
  }

  Future<void> _getStudentProfile(String studentId) async {
    String urlString =
        '${ApiEndpoint.appBaseUrl9}${ApiEndpoint.studentProfile}/$studentId';
    debugPrint("$urlString");

    String? authorizeTokenData =
        await LocalStorage.getStringValue(key: LocalStorage.authorizeTokenData);

    if (authorizeTokenData == null) return;

    var authorizeTokenResult =
        AuthorizeTokenData.fromJson(jsonDecode(authorizeTokenData));

    var url = Uri.parse(urlString);
    setLoadingState(true);

    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${authorizeTokenResult.token}",
      },
    );
    debugPrint('Grogu --> status code =  ${response.statusCode}');
    debugPrint('Grogu --> body = ${response.body}');
    setLoadingState(false);

    if (response.body.isEmpty) return;

    StudentProfileResult studentProfileResult =
        StudentProfileResult.fromJson(jsonDecode(response.body));

    if (response.statusCode != 200) {
      appDialogHelper?.showErrorDialog(
        errorMessage: studentProfileResult.message ?? 'something when wrong',
        errorCode: studentProfileResult.code?.toString() ?? '',
      );
      return;
    }
    if (studentProfileResult.studentProfileData != null) {
      studentProfileDataList.value =
          _generateListOfProfileData(studentProfileResult.studentProfileData!);
    }
  }

  Future<void> getStudentScore() async {
    String urlString =
        '${ApiEndpoint.appBaseUrl9}${ApiEndpoint.studentScore}/${selectedStudentId.value}';
    debugPrint("$urlString");

    String? authorizeTokenData =
        await LocalStorage.getStringValue(key: LocalStorage.authorizeTokenData);

    if (authorizeTokenData == null) return;

    var authorizeTokenResult =
        AuthorizeTokenData.fromJson(jsonDecode(authorizeTokenData));

    var url = Uri.parse(urlString);
    setLoadingState(true);

    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${authorizeTokenResult.token}",
      },
    );
    debugPrint('Grogu --> status code =  ${response.statusCode}');
    debugPrint('Grogu --> body = ${response.body}');
    setLoadingState(false);

    if (response.body.isEmpty) return;

    StudentScoreResult studentScoreResult =
        StudentScoreResult.fromJson(jsonDecode(response.body));

    if (response.statusCode != 200) {
      appDialogHelper?.showErrorDialog(
        errorMessage: studentScoreResult.message ?? 'something when wrong',
        errorCode: studentScoreResult.code?.toString() ?? '',
      );
      return;
    }
    if (studentScoreResult.studentScore != null) {
      studentScoreList.value =
          _generateStudentScoreItemList(studentScoreResult.studentScore!);
    }
  }

  List<StudyItem> _generateListOfProfileData(
      StudentProfileData studentProfileData) {
    List<StudyItem> studyItemList = [];
    studyItemList.add(
      StudyItem(
        id: 0,
        title: studentProfileData.branchNameEn ?? '',
        label: 'Branch name in English',
        isFixedEnglishLanguage: true,
      ),
    );
    studyItemList.add(
      StudyItem(
        id: 1,
        title: studentProfileData.branchNameKh ?? '',
        label: 'Branch name in Khmer',
        isFixedKhmerLanguage: true,
      ),
    );
    studyItemList.add(
      StudyItem(
        id: 2,
        title: studentProfileData.facultyEn ?? '',
        label: 'Faculty name in English',
        isFixedEnglishLanguage: true,
      ),
    );
    studyItemList.add(
      StudyItem(
        id: 3,
        title: studentProfileData.facultyKh ?? '',
        label: 'Faculty name in Khmer',
        isFixedKhmerLanguage: true,
      ),
    );
    studyItemList.add(
      StudyItem(
        id: 4,
        title: studentProfileData.specializationEn ?? '',
        label: 'Field in English',
        isFixedEnglishLanguage: true,
      ),
    );
    studyItemList.add(
      StudyItem(
        id: 5,
        title: studentProfileData.specializationKh ?? '',
        label: 'Field in Khmer',
        isFixedKhmerLanguage: true,
      ),
    );
    studyItemList.add(
      StudyItem(
        id: 6,
        title: studentProfileData.degreeEn ?? '',
        label: 'Degree in English',
        isFixedEnglishLanguage: true,
      ),
    );
    studyItemList.add(
      StudyItem(
        id: 7,
        title: studentProfileData.degreeKh ?? '',
        label: 'Degree in Khmer',
        isFixedKhmerLanguage: true,
      ),
    );
    return studyItemList;
  }

  List<StudentScoreItem> _generateStudentScoreItemList(
      List<StudentScore> studentScore) {
    if (studentScore.isEmpty) return [];

    Map<String, List<StudentScore>> studentScoreGroupByTerm = {};

    for (var score in studentScore) {
      final term = score.term;
      if (term == null) break;
      studentScoreGroupByTerm.putIfAbsent(term, () => []).add(score);
    }

    List<StudentScoreItem> studentScoreItemList = [];

    studentScoreGroupByTerm.forEach((term, listOfStudentScore) {
      final subjects = listOfStudentScore.asMap().entries.map((entry) {
        final index = entry.key + 1;
        final score = entry.value;

        final gpv = _calculateGpv(score.grade ?? '');

        return Subject(
          numberOrder: index,
          name: score.subjectName ?? "",
          midtermResult: score.midtermResult ?? 0.0,
          finalResult: score.finalResult ?? 0.0,
          credit: double.tryParse(score.credit ?? "0") ?? 0,
          total: score.totalResult ?? 0.0,
          gpv: gpv,
          grade: score.grade ?? "",
        );
      }).toList();

      studentScoreItemList.add(StudentScoreItem(
        id: int.tryParse(term) ?? 0 - 1,
        term: term,
        termTitle:
            "Year ${((int.parse(term) - 1) ~/ 2) + 1} Semester ${((int.parse(term) - 1) % 2) + 1}",
        subjectList: subjects,
      ));
    });

    return studentScoreItemList;
  }

  double _calculateGpv(String grade) {
    switch (grade) {
      case "A":
        return 4.0;
      case "A-":
        return 3.7;
      case "B+":
        return 3.5;
      case "B":
        return 3.0;
      case "C+":
        return 2.5;
      case "C":
        return 2.0;
      case "D":
        return 1.0;
      case "F":
        return 0.0;
      default:
        return 0.0;
    }
  }
}
