import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_app/src/common/base_get_x_controller.dart';
import 'package:school_app/src/core/auth/login/model/login_result.dart';
import 'package:school_app/src/modules/create_user_with_branch/model/university_branch_result.dart';
import 'package:school_app/src/modules/create_user_with_branch/model/user_type_result.dart';
import 'package:school_app/src/modules/user_dashboard/model/class_schedule_link_result.dart';
import 'package:school_app/src/modules/user_dashboard/model/class_schedule_result.dart';
import 'package:school_app/src/modules/user_dashboard/model/student_id_result.dart';
import 'package:school_app/src/modules/user_dashboard/model/student_profile_result.dart';
import 'package:school_app/src/modules/user_dashboard/model/student_score_result.dart';

import '../../../common/api_endpoint.dart';
import '../../../common/helpers/local_storage.dart';
import '../../../common/model/custom_drop_down_menu_item.dart';
import '../../../core/auth/login/model/authorize_token_result.dart';
import '../model/study_item.dart';
import '../model/study_result_item.dart';

class UserDashboardController extends BaseGetXController {
  var classScheduleResult = ClassScheduleResult().obs;
  var studentIdList = <String>[].obs;
  var selectedStudentId = ''.obs;
  var studentProfileDataList = <StudyItem>[].obs;
  var studentScoreList = <StudentScoreItem>[].obs;
  var universityBranchDropDownItemList = <CustomDropDownMenuItem>[].obs;
  var studentIdDropDownItemList = <CustomDropDownMenuItem>[].obs;
  var scheduleCodeTextEditingController = TextEditingController().obs;
  var universityBranchTextEditingController = TextEditingController().obs;
  var studentIdTextEditingController = TextEditingController().obs;
  var selectedTabViewIndex = 0;
  var isInvalidScheduleCode = false.obs;
  var invalidScheduleCodeDescription = "".obs;
  UniversityBranchResult? _universityBranchResult;
  UniversityBranchData? _selectedUniversityBranch;
  String? _selectedStudentIdClassTab;

  @override
  void onInit() async {
    await _getStudentId();
    super.onInit();
  }

  void resetScheduleCodeValidation() {
    isInvalidScheduleCode.value = false;
    invalidScheduleCodeDescription.value = '';
  }

  void setSelectedTabViewIndex(int index) {
    selectedTabViewIndex = index;
    update();
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

  void setSelectedStudentIdClassTab(
      CustomDropDownMenuItem selectedStudentIdClassTabDropDownItem) {
    for (int index = 0; index < studentIdList.value.length; index++) {
      if (studentIdList.value[index].toLowerCase() ==
          selectedStudentIdClassTabDropDownItem.value.toLowerCase()) {
        _selectedStudentIdClassTab = studentIdList.value[index];
        break;
      }
    }
  }

  Future<void> setSelectedStudentId(String studentId) async {
    if (selectedStudentId.value.toLowerCase() == studentId.toLowerCase()) {
      return;
    }

    selectedStudentId.value = studentId;
    debugPrint(studentId);

    await _getStudentProfile(studentId);
  }

  Future<void> initializeDataForClassTab() async {
    if (universityBranchDropDownItemList.value.isEmpty) {
      universityBranchDropDownItemList.value = await _getUniversityBranch();
    }
    if (studentIdDropDownItemList.value.isEmpty) {
      studentIdDropDownItemList.value =
          _generateStudentIdCustomDropDownMenuItem(studentIdList.value);
    }
    _selectedStudentIdClassTab = studentIdList.value.firstOrNull;
    getClassList();
  }

  Future<void> linkClassSchedule({VoidCallback? actionOnSuccess}) async {
    if (scheduleCodeTextEditingController.value.text.isEmpty) {
      isInvalidScheduleCode.value = true;
      invalidScheduleCodeDescription.value = 'Please input schedule code';
    }

    if (isInvalidScheduleCode.value ||
        _selectedStudentIdClassTab == null ||
        _selectedStudentIdClassTab?.isEmpty == true ||
        _selectedUniversityBranch == null) return;

    String urlString = '${ApiEndpoint.webBaseUrl}${ApiEndpoint.scheduleLink}';
    var url = Uri.parse(urlString);
    var requestBody = jsonEncode({
      "branchId": _selectedUniversityBranch?.branchId,
      "branchShortName": _selectedUniversityBranch?.shortName,
      "scheduleId": scheduleCodeTextEditingController.value.text,
      "studentId": _selectedStudentIdClassTab,
    });
    debugPrint(
        "Grogu --> urlString = $urlString <==> requestBody = $requestBody}");
    setLoadingState(true);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: requestBody,
    );
    debugPrint('Grogu --> status code =  ${response.statusCode}');
    debugPrint('Grogu --> body = ${response.body}');
    setLoadingState(false);

    if (response.body.isEmpty) return;

    ClassScheduleLinkResult classScheduleLinkResult =
        ClassScheduleLinkResult.fromJson(jsonDecode(response.body));

    if (classScheduleLinkResult.code != '200') {
      appDialogHelper?.showErrorDialog(
        errorMessage: classScheduleLinkResult.message ?? 'something when wrong',
        errorCode: classScheduleLinkResult.code ?? '',
      );
      return;
    }

    actionOnSuccess?.call();
    scheduleCodeTextEditingController.value.text = '';
    _selectedStudentIdClassTab = null;
    _selectedUniversityBranch = null;
  }

  Future<void> getClassList() async {
    if (_selectedStudentIdClassTab == null ||
        _selectedStudentIdClassTab?.isEmpty == true) return;

    String urlString =
        '${ApiEndpoint.webBaseUrl}${ApiEndpoint.scheduleClassList}';
    debugPrint(urlString);

    var url = Uri.parse(urlString);
    setLoadingState(true);

    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "studentId": _selectedStudentIdClassTab,
      }),
    );
    debugPrint('Grogu --> status code =  ${response.statusCode}');
    debugPrint('Grogu --> body = ${response.body}');
    setLoadingState(false);

    if (response.body.isEmpty) return;

    classScheduleResult.value =
        ClassScheduleResult.fromJson(jsonDecode(response.body));

    if (response.statusCode != 200) {
      appDialogHelper?.showErrorDialog(
        errorMessage:
            classScheduleResult.value.message ?? 'something when wrong',
        errorCode: classScheduleResult.value.code ?? '',
      );
    }
  }

  // Future<void> checkInAndOut() async {
  //   String? universityBranchDataString = await LocalStorage.getStringValue(
  //       key: LocalStorage.universityBranchData);
  //   if (universityBranchDataString == null) return;
  //   var universityBranchData =
  //       UniversityBranchData.fromJson(jsonDecode(universityBranchDataString));
  //
  //   String urlString =
  //       '${ApiEndpoint.webBaseUrl}${ApiEndpoint.classSubjectList}';
  //   debugPrint(urlString);
  //
  //   var url = Uri.parse(urlString);
  //   setLoadingState(true);
  //
  //   var response = await http.post(
  //     url,
  //     headers: {
  //       "Content-Type": "application/json",
  //     },
  //     body: jsonEncode({
  //       "branchId": universityBranchData.branchId,
  //       "branchShortName": universityBranchData.shortName,
  //       "scheduleId": "5122",
  //       "studentId": selectedStudentId.value,
  //       "latitude": "12.2323",
  //       "longitude": "34.3434",
  //       "subjectId": "1750",
  //       "id": 0
  //     }),
  //   );
  //   debugPrint('Grogu --> status code =  ${response.statusCode}');
  //   debugPrint('Grogu --> body = ${response.body}');
  //   setLoadingState(false);
  //
  //   if (response.body.isEmpty) return;
  //
  //   // classTimeScheduleResult.value =
  //   //     ClassTimeScheduleResult.fromJson(jsonDecode(response.body));
  //   //
  //   // if (response.statusCode != 200) {
  //   //   appDialogHelper?.showErrorDialog(
  //   //     errorMessage:
  //   //         classTimeScheduleResult.value.message ?? 'something when wrong',
  //   //     errorCode: '',
  //   //   );
  //   // }
  // }

  // Future<void> getCheckInAndOutHistory() async {
  //   String? universityBranchDataString = await LocalStorage.getStringValue(
  //       key: LocalStorage.universityBranchData);
  //   if (universityBranchDataString == null) return;
  //   var universityBranchData =
  //       UniversityBranchData.fromJson(jsonDecode(universityBranchDataString));
  //
  //   String urlString =
  //       '${ApiEndpoint.webBaseUrl}${ApiEndpoint.classCheckInAndCheckOutHistoryList}';
  //   debugPrint(urlString);
  //
  //   var url = Uri.parse(urlString);
  //   setLoadingState(true);
  //
  //   var response = await http.post(
  //     url,
  //     headers: {
  //       "Content-Type": "application/json",
  //     },
  //     body: {
  //       "branchId": universityBranchData.branchId,
  //       "branchShortName": universityBranchData.shortName,
  //       "scheduleId": "5122",
  //       "subjectId": "1750",
  //       "studentId": selectedStudentId.value,
  //     },
  //   );
  //   debugPrint('Grogu --> status code =  ${response.statusCode}');
  //   debugPrint('Grogu --> body = ${response.body}');
  //   setLoadingState(false);
  //
  //   if (response.body.isEmpty) return;
  //
  //   // classTimeScheduleResult.value =
  //   //     ClassTimeScheduleResult.fromJson(jsonDecode(response.body));
  //   //
  //   // if (response.statusCode != 200) {
  //   //   appDialogHelper?.showErrorDialog(
  //   //     errorMessage:
  //   //         classTimeScheduleResult.value.message ?? 'something when wrong',
  //   //     errorCode: '',
  //   //   );
  //   // }
  // }

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
    debugPrint(urlString);

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
    debugPrint(urlString);

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
    debugPrint(urlString);

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

  Future<List<CustomDropDownMenuItem>> _getUniversityBranch() async {
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
      return [];
    }

    _universityBranchResult =
        UniversityBranchResult.fromJson(jsonDecode(response.body));

    if (_universityBranchResult?.code != 200) {
      appDialogHelper?.showErrorDialog(
        errorMessage: _universityBranchResult?.message ?? '',
        errorCode: '${_universityBranchResult?.code}',
      );
      return [];
    }

    return _generateUniversityList(
      _universityBranchResult?.universityBranchData,
    );
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

  List<CustomDropDownMenuItem> _generateStudentIdCustomDropDownMenuItem(
      List<String> listOfStudentId) {
    if (listOfStudentId.isEmpty) return [];
    List<CustomDropDownMenuItem> studentIdCustomDropDownMenuItemList = [];

    for (int index = 0; index < listOfStudentId.length; index++) {
      studentIdCustomDropDownMenuItemList.add(
        CustomDropDownMenuItem(
          value: listOfStudentId[index],
          id: index,
          title: listOfStudentId[index],
        ),
      );
    }

    return studentIdCustomDropDownMenuItemList;
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
