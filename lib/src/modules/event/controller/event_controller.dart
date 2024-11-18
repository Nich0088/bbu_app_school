import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../../common/api_endpoint.dart';
import '../../../common/helpers/app_dialog_helper.dart';
import '../models/event_new_data.dart';

class EventController extends GetxController {
  @factoryMethod
  static init() => Get.put(EventController());

  var eventResult = EventResult().obs;
  var isShowLoading = false;
  AppDialogHelper? _appDialogHelper;

  @override
  void onInit() async {
    super.onInit();
    await _getContactList();
  }

  void register(BuildContext context) {
    _appDialogHelper = AppDialogHelper(context: context);
  }

  Future<void> _getContactList() async {
    String urlString =
        ApiEndpoint.unAuthorizeBastUrl + ApiEndpoint.newsAndEvent;
    debugPrint(urlString);
    var url = Uri.parse(urlString);
    _setLoadingState(true);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );
    debugPrint("${jsonDecode(response.body)}");
    debugPrint("${jsonDecode(response.statusCode.toString())}");
    if (response.statusCode == 200) {
      eventResult.value = EventResult.fromJson(jsonDecode(response.body));
    } else {
      _appDialogHelper?.showErrorDialog(
        errorMessage: 'something when wrong',
        errorCode: '',
      );
    }
    _setLoadingState(false);
  }

  void _setLoadingState(bool isLoading) {
    isShowLoading = isLoading;
    update();
  }
}
