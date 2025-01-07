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

import '../../../common/api_endpoint.dart';
import '../../../common/helpers/local_storage.dart';
import '../../../core/auth/login/model/authorize_token_result.dart';
import '../model/class_time_schedule_result.dart';
import '../model/study_item.dart';
import '../model/study_result_item.dart';

class UserDashboardController extends BaseGetXController {
  List<StudyResultItem> get studyResultItemList => [
        StudyResultItem(
          id: 0,
          term: "1",
          termTitle: "Year 1 Semester 1",
          subjectList: [
            Subject(
              numberOrder: 1,
              name: "Introduction to Programming",
              midtermResult: 40,
              finalResult: 35,
              credit: 3,
              total: 75,
              gpv: 3.5,
              grade: "B+",
            ),
            Subject(
              numberOrder: 2,
              name: "Mathematics I",
              midtermResult: 38,
              finalResult: 32,
              credit: 3,
              total: 70,
              gpv: 3.0,
              grade: "B",
            ),
            Subject(
              numberOrder: 3,
              name: "English for Academic Purposes",
              midtermResult: 42,
              finalResult: 45,
              credit: 3,
              total: 87,
              gpv: 4.0,
              grade: "A",
            ),
            Subject(
              numberOrder: 4,
              name: "Computer Fundamentals",
              midtermResult: 30,
              finalResult: 40,
              credit: 3,
              total: 70,
              gpv: 3.0,
              grade: "B",
            ),
            Subject(
              numberOrder: 5,
              name: "Digital Logic Design",
              midtermResult: 35,
              finalResult: 35,
              credit: 3,
              total: 70,
              gpv: 3.0,
              grade: "B",
            ),
          ],
        ),
        StudyResultItem(
          id: 1,
          term: "2",
          termTitle: "Year 1 Semester 2",
          subjectList: [
            Subject(
              numberOrder: 1,
              name: "Data Structures",
              midtermResult: 45,
              finalResult: 40,
              credit: 3,
              total: 85,
              gpv: 4.0,
              grade: "A",
            ),
            Subject(
              numberOrder: 2,
              name: "Mathematics II",
              midtermResult: 32,
              finalResult: 38,
              credit: 3,
              total: 70,
              gpv: 3.0,
              grade: "B",
            ),
            Subject(
              numberOrder: 3,
              name: "Discrete Mathematics",
              midtermResult: 30,
              finalResult: 30,
              credit: 3,
              total: 60,
              gpv: 2.0,
              grade: "C",
            ),
            Subject(
              numberOrder: 4,
              name: "Object-Oriented Programming",
              midtermResult: 40,
              finalResult: 42,
              credit: 3,
              total: 82,
              gpv: 3.8,
              grade: "A-",
            ),
            Subject(
              numberOrder: 5,
              name: "Ethics in Computing",
              midtermResult: 40,
              finalResult: 40,
              credit: 3,
              total: 80,
              gpv: 3.7,
              grade: "A-",
            ),
          ],
        ),
        StudyResultItem(
          id: 2,
          term: "3",
          termTitle: "Year 2 Semester 1",
          subjectList: [
            Subject(
              numberOrder: 1,
              name: "Algorithms and Complexity",
              midtermResult: 48,
              finalResult: 40,
              credit: 3,
              total: 88,
              gpv: 4.0,
              grade: "A",
            ),
            Subject(
              numberOrder: 2,
              name: "Operating Systems",
              midtermResult: 38,
              finalResult: 30,
              credit: 3,
              total: 68,
              gpv: 2.5,
              grade: "C+",
            ),
            Subject(
              numberOrder: 3,
              name: "Database Systems",
              midtermResult: 42,
              finalResult: 38,
              credit: 3,
              total: 80,
              gpv: 3.7,
              grade: "A-",
            ),
            Subject(
              numberOrder: 4,
              name: "Computer Architecture",
              midtermResult: 34,
              finalResult: 35,
              credit: 3,
              total: 69,
              gpv: 3.0,
              grade: "B",
            ),
            Subject(
              numberOrder: 5,
              name: "Professional Ethics",
              midtermResult: 30,
              finalResult: 40,
              credit: 3,
              total: 70,
              gpv: 3.0,
              grade: "B",
            ),
          ],
        ),
        StudyResultItem(
          id: 3,
          term: "4",
          termTitle: "Year 2 Semester 2",
          subjectList: [
            Subject(
              numberOrder: 1,
              name: "Software Engineering",
              midtermResult: 45,
              finalResult: 42,
              credit: 3,
              total: 87,
              gpv: 4.0,
              grade: "A",
            ),
            Subject(
              numberOrder: 2,
              name: "Computer Networks",
              midtermResult: 35,
              finalResult: 30,
              credit: 3,
              total: 65,
              gpv: 2.5,
              grade: "C+",
            ),
            Subject(
              numberOrder: 3,
              name: "Artificial Intelligence",
              midtermResult: 40,
              finalResult: 40,
              credit: 3,
              total: 80,
              gpv: 3.7,
              grade: "A-",
            ),
            Subject(
              numberOrder: 4,
              name: "Web Development",
              midtermResult: 38,
              finalResult: 40,
              credit: 3,
              total: 78,
              gpv: 3.5,
              grade: "B+",
            ),
            Subject(
              numberOrder: 5,
              name: "Mobile Application Development",
              midtermResult: 30,
              finalResult: 35,
              credit: 3,
              total: 65,
              gpv: 2.5,
              grade: "C+",
            ),
          ],
        ),
        StudyResultItem(
          id: 4,
          term: "5",
          termTitle: "Year 3 Semester 1",
          subjectList: [
            Subject(
              numberOrder: 1,
              name: "Advanced PHP and MySQL",
              midtermResult: 39,
              finalResult: 30,
              credit: 3,
              total: 69,
              gpv: 2.5,
              grade: "C+",
            ),
            Subject(
              numberOrder: 2,
              name: "Client/Server App Development",
              midtermResult: 33,
              finalResult: 40,
              credit: 3,
              total: 73,
              gpv: 3.0,
              grade: "B",
            ),
            Subject(
              numberOrder: 3,
              name: "Introduction to Linux OS",
              midtermResult: 34,
              finalResult: 36,
              credit: 3,
              total: 70,
              gpv: 3.0,
              grade: "B",
            ),
            Subject(
              numberOrder: 4,
              name: "Network Administration",
              midtermResult: 26,
              finalResult: 34,
              credit: 3,
              total: 60,
              gpv: 2.0,
              grade: "C",
            ),
            Subject(
              numberOrder: 5,
              name: "System Analysis and Design",
              midtermResult: 12,
              finalResult: 0,
              credit: 3,
              total: 12,
              gpv: 0.0,
              grade: "F",
            ),
          ],
        ),
        StudyResultItem(
          id: 5,
          term: "6",
          termTitle: "Year 3 Semester 2",
          subjectList: [
            Subject(
              numberOrder: 1,
              name: "Data Structures and Algorithms",
              midtermResult: 45,
              finalResult: 40,
              credit: 3,
              total: 85,
              gpv: 4.0,
              grade: "A",
            ),
            Subject(
              numberOrder: 2,
              name: "Software Engineering",
              midtermResult: 32,
              finalResult: 38,
              credit: 3,
              total: 70,
              gpv: 3.0,
              grade: "B",
            ),
            Subject(
              numberOrder: 3,
              name: "Operating Systems",
              midtermResult: 28,
              finalResult: 30,
              credit: 3,
              total: 58,
              gpv: 2.0,
              grade: "C",
            ),
            Subject(
              numberOrder: 4,
              name: "Database Management Systems",
              midtermResult: 40,
              finalResult: 45,
              credit: 3,
              total: 85,
              gpv: 4.0,
              grade: "A",
            ),
            Subject(
              numberOrder: 5,
              name: "Computer Networks",
              midtermResult: 35,
              finalResult: 30,
              credit: 3,
              total: 65,
              gpv: 2.5,
              grade: "C+",
            ),
          ],
        ),
        StudyResultItem(
          id: 6,
          term: "7",
          termTitle: "Year 4 Semester 1",
          subjectList: [
            Subject(
              numberOrder: 1,
              name: "Cloud Computing",
              midtermResult: 40,
              finalResult: 42,
              credit: 3,
              total: 82,
              gpv: 3.8,
              grade: "A-",
            ),
            Subject(
              numberOrder: 2,
              name: "Cybersecurity",
              midtermResult: 35,
              finalResult: 30,
              credit: 3,
              total: 65,
              gpv: 2.5,
              grade: "C+",
            ),
            Subject(
              numberOrder: 3,
              name: "Big Data Analytics",
              midtermResult: 45,
              finalResult: 40,
              credit: 3,
              total: 85,
              gpv: 4.0,
              grade: "A",
            ),
            Subject(
              numberOrder: 4,
              name: "Research Methodology",
              midtermResult: 38,
              finalResult: 40,
              credit: 3,
              total: 78,
              gpv: 3.5,
              grade: "B+",
            ),
            Subject(
              numberOrder: 5,
              name: "Distributed Systems",
              midtermResult: 30,
              finalResult: 35,
              credit: 3,
              total: 65,
              gpv: 2.5,
              grade: "C+",
            ),
          ],
        ),
        StudyResultItem(
          id: 7,
          term: "8",
          termTitle: "Year 4 Semester 2",
          subjectList: [
            Subject(
              numberOrder: 1,
              name: "Capstone Project",
              midtermResult: 50,
              finalResult: 45,
              credit: 6,
              total: 95,
              gpv: 4.0,
              grade: "A",
            ),
            Subject(
              numberOrder: 2,
              name: "Entrepreneurship",
              midtermResult: 40,
              finalResult: 38,
              credit: 3,
              total: 78,
              gpv: 3.7,
              grade: "A-",
            ),
            Subject(
              numberOrder: 3,
              name: "Advanced Computer Networks",
              midtermResult: 35,
              finalResult: 35,
              credit: 3,
              total: 70,
              gpv: 3.0,
              grade: "B",
            ),
            Subject(
              numberOrder: 4,
              name: "Software Testing",
              midtermResult: 32,
              finalResult: 38,
              credit: 3,
              total: 70,
              gpv: 3.0,
              grade: "B",
            ),
            Subject(
              numberOrder: 5,
              name: "Internet of Things",
              midtermResult: 28,
              finalResult: 30,
              credit: 3,
              total: 58,
              gpv: 2.0,
              grade: "C",
            ),
          ],
        ),
      ];

  var classTimeScheduleResult = ClassTimeScheduleResult().obs;
  var studentIdList = <String>[].obs;
  var selectedStudentId = ''.obs;
  var studentProfileDataList = <StudyItem>[].obs;

  LoginController loginController = Get.put(LoginController());

  @override
  void onInit() async {
    // await _getClassSchedule();
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

  // Future<void> _getClassSchedule() async {
  //   String urlString =
  //       '${ApiEndpoint.appBaseUrl9}${ApiEndpoint.classTimeSchedule}/${AppConstant.mockBranch}/${AppConstant.mockScheduleId}/${AppConstant.mockScheduleStatus}';
  //   debugPrint("$urlString");
  //
  //   String? authorizeTokenData =
  //       await LocalStorage.getStringValue(key: LocalStorage.authorizeTokenData);
  //
  //   if (authorizeTokenData == null) return;
  //
  //   var authorizeTokenResult =
  //       AuthorizeTokenData.fromJson(jsonDecode(authorizeTokenData));
  //
  //   var url = Uri.parse(urlString);
  //   setLoadingState(true);
  //
  //   var response = await http.get(
  //     url,
  //     headers: {
  //       "Content-Type": "application/json",
  //       "Authorization": "Bearer ${authorizeTokenResult.token}",
  //     },
  //   );
  //   debugPrint('Grogu --> status code =  ${response.statusCode}');
  //   debugPrint('Grogu --> body = ${response.body}');
  //   setLoadingState(false);
  //
  //   if (response.body.isEmpty) return;
  //
  //   classTimeScheduleResult.value =
  //       ClassTimeScheduleResult.fromJson(jsonDecode(response.body));
  //
  //   if (response.statusCode != 200) {
  //     appDialogHelper?.showErrorDialog(
  //       errorMessage:
  //           classTimeScheduleResult.value.message ?? 'something when wrong',
  //       errorCode: '',
  //     );
  //   }
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
}
