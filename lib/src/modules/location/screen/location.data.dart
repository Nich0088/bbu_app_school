import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../common/api_endpoint.dart';
import 'location_res.dart';

class LocationData {
  //List<LocationModel> list = [];
  late LocationRes resultRequest;

  Future<LocationRes> getLocationUsList() async {
    String url = ApiEndpoint.appBaseUrl9 + ApiEndpoint.viewLocation;
    var url1 = Uri.parse(url);
    var response = await http.get(url1);
    if (response.statusCode == 200) {
      final jsonresponse = jsonDecode(response.body);
      //final newsJson = map["location"];
      //newsJson.forEach((data) {
      resultRequest = LocationRes.fromJson(jsonresponse);
      // print(model.campus);
      //list.add(model);
      //});
    }
    return resultRequest;
  }
}
