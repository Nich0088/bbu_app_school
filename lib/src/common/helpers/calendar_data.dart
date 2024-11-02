import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../modules/dashboard/models/calendar_model_res.dart';
import '../api_endpoint.dart';

class CalendarData {
  //List<CalendarModel> list = [];
  late CalendarRes resultRequest;

  Future<CalendarRes> getList(String year, String month) async {
    int month1 = int.parse(month);
    var monthnumber = month;
    if (month1 < 10) {
      monthnumber = "0$month1";
    }
    String url =
        "${ApiEndpoint.unAuthorizeBastUrl}${ApiEndpoint.calendar}?year=$year&month=$monthnumber";
    var url1 = Uri.parse(url);
    var response = await http.get(url1);
    if (response.statusCode == 200) {
      /*final map = json.decode(response.body);
       final newsJson = map["calendar"];
      newsJson.forEach((data) {
        final model = CalendarModel.fromJson(data);
        // print(model.title);
        list.add(model);
      }); */

      final jsonresponse = jsonDecode(response.body);
      final sms = CalendarRes.fromJson(jsonresponse);
      resultRequest = sms;
    }
    return resultRequest;
  }
}
