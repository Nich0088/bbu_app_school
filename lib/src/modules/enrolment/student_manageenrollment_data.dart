import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:school_app/src/modules/enrolment/student_info_pay_res.dart';
import 'package:school_app/src/modules/enrolment/student_phonepin_con_req.dart';
import 'package:school_app/src/modules/enrolment/student_phonepin_con_res.dart';

import '../../common/auth_register.dart';

class StudentMangeEnrollData {
  late StudentInfoPayRes resultRequest;

  String messageModel = "student mange enrollment";

  Future<StudentInfoPayRes> getDataStudentEnroll(String studentIdTemp) async {
    ///api/v1/newstudent?student_id=02f3oofjvfzwkoll44uwjv5l
    String url =
        "${AuthRegister.basicUrlRegester}${AuthRegister.newStudent1}?student_id=$studentIdTemp";

    String username = AuthRegister.authUsername1;
    String password = AuthRegister.authPpassword1;
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    var headers1 = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': basicAuth
    };

    var url1 = Uri.parse(url);
    var response = await http.get(url1, headers: headers1);

    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());

      final jsonresponse = jsonDecode(response.body);
      final sms = StudentInfoPayRes.fromJson(jsonresponse);
      if (sms.code == 200) {
        resultRequest = sms;
      }
      return resultRequest;
    } else if (response.statusCode == 401) {
      DataStudentInfo dataStudentInfo = DataStudentInfo(
          studentIdTemp: "",
          studentNameEn: "",
          studentNameKh: "",
          firstNameEn: "",
          firstNameKh: "",
          lastNameEn: "",
          lastNameKh: "",
          sex: "",
          dateOfBirth: DateTime.now(),
          placeOfBirth: "",
          photo: "",
          photoUrl: "",
          phone: "",
          branchNameEn: "",
          branchNameKh: "",
          specializationEn: "",
          specializationKh: "",
          degreeEn: "",
          degreeKh: "",
          facultyEn: "",
          facultyKh: "",
          chooseAcademicPrice: 0.0,
          studyTime: "");
      StudentPayinfo studentPayinfo = StudentPayinfo(
          paymenTStudentId: 0,
          paymenTGatewaYs: "",
          studenTId: "",
          paYDate: DateTime.now(),
          amount: 0.0,
          discount: 0.0);

      StudentInfoPayRes usTem = StudentInfoPayRes(
          message: "Unauthorized",
          code: 401,
          studentInfo: dataStudentInfo,
          studentPayinfo: studentPayinfo);
      ////////////
      resultRequest = usTem;
      return resultRequest;
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
      throw Exception('Failed to report $messageModel by itemid request..');
    }
  }

  late StudentPhonePinConRes requestPhonePinConnect;

  Future<StudentPhonePinConRes> requestConnectPhonePin(
      StudentPhonePinConReq req) async {
    ///api/v1/newstudent?student_id=02f3oofjvfzwkoll44uwjv5l
    String url = AuthRegister.basicUrlRegester + AuthRegister.phonepinCodeConn;
    StudentPhonePinConReq createReq = req;
    String username = AuthRegister.authUsername1;
    String password = AuthRegister.authPpassword1;
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    var headers1 = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': basicAuth
    };

    var url1 = Uri.parse(url);
    var response = await http.post(
      url1,
      headers: headers1,
      body: json.encode(createReq.toJson()),
    );

    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());

      final jsonresponse = jsonDecode(response.body);
      final sms = StudentPhonePinConRes.fromJson(jsonresponse);
      if (sms.code == 200) {
        requestPhonePinConnect = sms;
      }
      return requestPhonePinConnect;
    } else if (response.statusCode == 401) {
      StudentPhonePinConRes usTem = StudentPhonePinConRes(
          message: "Unauthorized", code: 401, studenttemid: "");
      ////////////
      requestPhonePinConnect = usTem;
      return requestPhonePinConnect;
    } else if (response.statusCode == 404) {
      StudentPhonePinConRes usTem = StudentPhonePinConRes(
          message: "Not found", code: 404, studenttemid: "");
      ////////////
      requestPhonePinConnect = usTem;
      return requestPhonePinConnect;
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
      throw Exception(
          'Failed to report phone pincode connect by itemid request..');
    }
  }
}
