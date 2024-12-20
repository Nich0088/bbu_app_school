import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:school_app/src/common/api_endpoint.dart';
import 'package:school_app/src/common/base_get_x_controller.dart';
import 'package:school_app/src/common/model/custom_drop_down_menu_item.dart';
import 'package:school_app/src/common/secret_key.dart';
import 'package:school_app/src/modules/registration_application/model/place_of_birth_result.dart';

class RegistrationApplicationController extends BaseGetXController {
  var firstNameInKhmerTextEditingController = TextEditingController().obs;
  var lastNameInKhmerTextEditingController = TextEditingController().obs;
  var firstNameInEnglishTextEditingController = TextEditingController().obs;
  var lastNameInEnglishTextEditingController = TextEditingController().obs;
  var phoneNumberTextEditingController = TextEditingController().obs;
  var sexTextEditingController = TextEditingController().obs;
  var dobTextEditingController = TextEditingController().obs;
  var placeOfBirthTextEditingController = TextEditingController().obs;
  var selectedImage = Rxn<File>();
  var placeOfBirthList = <CustomDropDownMenuItem>[].obs;

  List<CustomDropDownMenuItem> get sexesList => [
        CustomDropDownMenuItem(id: 0, title: 'Male', value: 'male'),
        CustomDropDownMenuItem(id: 1, title: 'Female', value: 'female'),
      ];

  @override
  void onInit() async {
    await _getPlaceOfBirth();
    super.onInit();
  }

  Future<void> _getPlaceOfBirth() async {
    String url = "${ApiEndpoint.registerBastUrl}${ApiEndpoint.placeOfBirth}";
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('${AppSecretKey.usernameSecretKey}:${AppSecretKey.passwordSecretKey}'))}';

    var headers1 = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': basicAuth,
      'Cookie': 'Language=en'
    };

    setLoadingState(true);

    var response = await http.get(Uri.parse(url), headers: headers1);
    debugPrint('Grogu --> ${response.body}');
    if (response.body.isEmpty) return;

    var placeOfBirthResult =
        PlaceOfBirthResult.fromJson(jsonDecode(response.body));

    setLoadingState(false);

    if (response.statusCode != 200) {
      appDialogHelper?.showErrorDialog(
        errorMessage: placeOfBirthResult.message ?? 'something when wrong',
        errorCode: '',
      );
      return;
    }

    placeOfBirthList.value = _generateCustomDropDownMenuPlaceOfBirth(
        placeOfBirthResult.placeOfBirthData);
  }

  List<CustomDropDownMenuItem> _generateCustomDropDownMenuPlaceOfBirth(
      List<PlaceOfBirthData>? placeOfBirthData) {
    List<CustomDropDownMenuItem> listCustomDropDownMenuItem = [];

    if (placeOfBirthData == null) return listCustomDropDownMenuItem;

    int placeOfBirthListLength = placeOfBirthData.length;
    for (int index = 0; index < placeOfBirthListLength; index++) {
      String placeOfBirth = placeOfBirthData[index].nameObj ?? '';
      listCustomDropDownMenuItem.add(CustomDropDownMenuItem(
        id: index,
        title: placeOfBirth,
        value: placeOfBirth,
      ));
    }

    return listCustomDropDownMenuItem;
  }
}
