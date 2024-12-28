import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../common/auth_register.dart';
import 'branch/res/branch_res.dart';
import 'branch/res/degree_res.dart';
import 'branch/res/faculty_res.dart';

class RegisterServiceNewData {
  late BranchRes resulReqBranch;

  String messageModel = "Branch";

  Future<BranchRes> getBranch() async {
    String url = AuthRegister.basicUrlRegester + AuthRegister.branBrach;

    String username = AuthRegister.authUsername1;
    String password = AuthRegister.authPpassword1;
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': basicAuth,
      //'Cookie': 'Language=en'
    };

    var url1 = Uri.parse(url);
    var response = await http.post(url1, headers: headers);

    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());

      final jsonresponse = jsonDecode(response.body);
      final sms = BranchRes.fromJson(jsonresponse);
      if (sms.code == 200) {
        resulReqBranch = sms;
      }
      return resulReqBranch;
    } else if (response.statusCode == 401) {
      List<DataBranchList> temtList1 = [];
      BranchRes usTem = BranchRes(
          message: "Unauthorized", code: 401, dataBranchList: temtList1);
      ////////////
      resulReqBranch = usTem;
      return resulReqBranch;
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
      throw Exception('Failed to report $messageModel by itemid request..');
    }
  }

  /////////////////degree=========
  late DegreesRes resulReqDegree;

  Future<DegreesRes> getDegree() async {
    String url = AuthRegister.basicUrlRegester + AuthRegister.branchDegree;

    String username = AuthRegister.authUsername1;
    String password = AuthRegister.authPpassword1;
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': basicAuth,
      'Cookie': 'Language=en'
    };

    var url1 = Uri.parse(url);
    var response = await http.post(url1, headers: headers);

    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());

      final jsonresponse = jsonDecode(response.body);
      final sms = DegreesRes.fromJson(jsonresponse);
      if (sms.code == 200) {
        resulReqDegree = sms;
      }
      return resulReqDegree;
    } else if (response.statusCode == 401) {
      List<DataDegreeList> temtList1 = [];
      DegreesRes usTem = DegreesRes(
          message: "Unauthorized", code: 401, dataListDegree: temtList1);
      ////////////
      resulReqDegree = usTem;
      return resulReqDegree;
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
      throw Exception('Failed to report Degree by itemid request..');
    }
  }

  /////////////////degree=========
  late FacultyRes resulReqFaculty;

  Future<FacultyRes> getFaculty(int degreeid) async {
    String url =
        "${AuthRegister.basicUrlRegester}${AuthRegister.branchFaculty}/$degreeid";

    String username = AuthRegister.authUsername1;
    String password = AuthRegister.authPpassword1;
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': basicAuth,
      'Cookie': 'Language=en'
    };

    var url1 = Uri.parse(url);
    var response = await http.post(url1, headers: headers);

    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());

      final jsonresponse = jsonDecode(response.body);
      final sms = FacultyRes.fromJson(jsonresponse);
      if (sms.code == 200) {
        resulReqFaculty = sms;
      }
      return resulReqFaculty;
    } else if (response.statusCode == 401) {
      List<DataFacultyList> temtList1 = [];
      FacultyRes usTem = FacultyRes(
          message: "Unauthorized", code: 401, dataFacultyList: temtList1);
      ////////////
      resulReqFaculty = usTem;
      return resulReqFaculty;
    } else {
      if (kDebugMode) {
        print(response.reasonPhrase);
      }
      throw Exception('Failed to report Faculty by itemid request..');
    }
  }
}
