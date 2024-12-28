import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../../common/api_endpoint.dart';
import '../model/faq_model.dart';

class FaqData {
  List<FaqModel> list = [];

  Future<void> getCallUsList() async {
    String url = ApiEndpoint.unAuthorizeBastUrl + ApiEndpoint.faq;
    debugPrint(url);
    var url1 = Uri.parse(url);
    var response = await http.get(url1);
    debugPrint('idk => ${response.body}');
    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      final newsJson = map["faq"];
      newsJson.forEach((data) {
        final model = FaqModel.fromJson(data);
        // print(model.question);
        list.add(model);
      });
    }
  }
}
