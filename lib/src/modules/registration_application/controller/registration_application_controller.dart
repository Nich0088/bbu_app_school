import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

class RegistrationApplicationController extends GetxController {
  @factoryMethod
  static init() => Get.put(RegistrationApplicationController());

  var firstNameInKhmerTextEditingController = TextEditingController().obs;
  var lastNameInKhmerTextEditingController = TextEditingController().obs;
  var firstNameInEnglishTextEditingController = TextEditingController().obs;
  var lastNameInEnglishTextEditingController = TextEditingController().obs;
  var phoneNumberTextEditingController = TextEditingController().obs;
  var sexTextEditingController = TextEditingController().obs;
}
