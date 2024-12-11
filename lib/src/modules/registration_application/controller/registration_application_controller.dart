import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:school_app/src/common/model/custom_drop_down_menu_item.dart';

class RegistrationApplicationController extends GetxController {
  @factoryMethod
  static init() => Get.put(RegistrationApplicationController());

  var firstNameInKhmerTextEditingController = TextEditingController().obs;
  var lastNameInKhmerTextEditingController = TextEditingController().obs;
  var firstNameInEnglishTextEditingController = TextEditingController().obs;
  var lastNameInEnglishTextEditingController = TextEditingController().obs;
  var phoneNumberTextEditingController = TextEditingController().obs;
  var sexTextEditingController = TextEditingController().obs;
  var dobTextEditingController = TextEditingController().obs;
  var placeOfBirthTextEditingController = TextEditingController().obs;
  var selectedImage = Rxn<File>();

  List<CustomDropDownMenuItem> get sexesList => [
        CustomDropDownMenuItem(id: 0, title: 'Male', value: 'male'),
        CustomDropDownMenuItem(id: 1, title: 'Female', value: 'female'),
      ];

  List<CustomDropDownMenuItem> get placeOfBirthList => [
        CustomDropDownMenuItem(
          id: 0,
          title: 'Phnom Penh',
          value: 'Phnom Penh',
        ),
        CustomDropDownMenuItem(
          id: 1,
          title: 'Takeo',
          value: 'Takeo',
        ),
        CustomDropDownMenuItem(
          id: 2,
          title: 'Kandal',
          value: 'Kandal',
        ),
        CustomDropDownMenuItem(
          id: 3,
          title: 'Kompong Speu',
          value: 'Kompong Speu',
        ),
      ];
}
