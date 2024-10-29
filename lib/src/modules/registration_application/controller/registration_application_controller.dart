import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:school_app/src/modules/registration_application/model/sex_menu_item.dart';

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

  List<SexMenuItem> get sexesList => [
        SexMenuItem(id: 0, title: 'Male'),
        SexMenuItem(id: 1, title: 'Female'),
      ];

  List<SexMenuItem> get placeOfBirthList => [
        SexMenuItem(id: 0, title: 'Phnom Penh'),
        SexMenuItem(id: 1, title: 'Takeo'),
        SexMenuItem(id: 2, title: 'Kandal'),
        SexMenuItem(id: 3, title: 'Kompong Speu'),
      ];
}
