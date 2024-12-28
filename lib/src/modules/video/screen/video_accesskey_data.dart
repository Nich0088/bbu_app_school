import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../common/api_endpoint.dart';
import '../../../common/auth_register.dart';
import '../../videoaccess/video_access_res.dart';

class VideoAccessKeyData {
  late VideoAccessKeyRes resultRequest;

  /* VideoAccessKeyDataList temData1=VideoAccessKeyDataList(id:0,
        accessName:"",
        urlBase:"",
        channelidKey1:"",
        key2:"",
        key3:""); */
  String messageModel = "Video Access Key";

  Future<VideoAccessKeyRes> getDataBaseKey() async {
    String url = ApiEndpoint.baseUrlStudentResult + AuthRegister.videoAccesskey;

    String username = AuthRegister.authUsername;
    String password = AuthRegister.authPpassword;
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': basicAuth,
      'Cookie': 'Language=en'
    };

    var url1 = Uri.parse(url);
    var response = await http.get(url1, headers: headers);

    if (response.statusCode == 200) {
      //print(await response.stream.bytesToString());

      final jsonresponse = jsonDecode(response.body);
      final sms = VideoAccessKeyRes.fromJson(jsonresponse);
      if (sms.code == 200) {
        resultRequest = sms;
      }
      return resultRequest;
    } else if (response.statusCode == 401) {
      List<VideoAccessKeyDataList> temtList1 = [];
      VideoAccessKeyRes usTem = VideoAccessKeyRes(
          message: "Unauthorized", code: 401, dataList: temtList1);
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
}
