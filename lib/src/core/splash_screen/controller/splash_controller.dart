import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_app/src/common/helpers/local_storage.dart';

import '../../../common/api_endpoint.dart';
import '../../auth/login/model/authorize_token_result.dart';

class SplashController extends GetxController {
  Future<void> determineRoute(
      {required VoidCallback actionOnTokenExist,
      required VoidCallback actionOnTokenNotExist}) async {
    await _getApiToken();

    String? userProfileData =
        await LocalStorage.getStringValue(key: LocalStorage.userProfileData);

    if (userProfileData != null) {
      actionOnTokenExist.call();
    } else {
      actionOnTokenNotExist.call();
    }
  }

  Future<void> _getApiToken() async {
    String urlString = ApiEndpoint.appBaseUrl9 + ApiEndpoint.authorizeToken;
    var url = Uri.parse(urlString);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "username": 'mich',
        "password": '1234',
      }),
    );
    var authorizeTokenResult =
        AuthorizeTokenResult.fromJson(jsonDecode(response.body));
    if (authorizeTokenResult.code == 200) {
      if (authorizeTokenResult.data?.token != null) {
        await LocalStorage.storeData(
          key: LocalStorage.authorizeTokenData,
          value: jsonEncode(authorizeTokenResult.data?.toJson()),
        );
      }
    }
  }
}
