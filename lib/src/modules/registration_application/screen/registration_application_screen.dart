import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../constants/app_setting.dart';
import '../controller/registration_application_controller.dart';

class RegistrationApplicationScreen extends StatefulWidget {
  const RegistrationApplicationScreen({super.key});

  @override
  State<RegistrationApplicationScreen> createState() =>
      _RegistrationApplicationScreenState();
}

class _RegistrationApplicationScreenState
    extends State<RegistrationApplicationScreen> {
  final RegistrationApplicationController _registrationApplicationController =
      Get.put(RegistrationApplicationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context,
        backgroundColor: AppColor.primaryColor,
        isDashboardAppBar: false,
        title: "Registration Application",
        isCenterTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Opacity(
              opacity: 0.7,
              child: Image.asset(
                AppLogo.appLogo,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12,
                          left: AppStyle.horizontalPadding,
                          right: AppStyle.horizontalPadding,
                        ),
                        child: CustomTextField(
                          controller: _registrationApplicationController
                              .firstNameInKhmerTextEditingController.value,
                          onChangeTextField: (value) {
                            //
                          },
                          label: "First name in Khmer",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12,
                          left: AppStyle.horizontalPadding,
                          right: AppStyle.horizontalPadding,
                        ),
                        child: CustomTextField(
                          controller: _registrationApplicationController
                              .lastNameInKhmerTextEditingController.value,
                          onChangeTextField: (value) {
                            //
                          },
                          label: "Last name in Khmer",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12,
                          left: AppStyle.horizontalPadding,
                          right: AppStyle.horizontalPadding,
                        ),
                        child: CustomTextField(
                          controller: _registrationApplicationController
                              .firstNameInEnglishTextEditingController.value,
                          onChangeTextField: (value) {
                            //
                          },
                          label: "First name in Latin",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12,
                          left: AppStyle.horizontalPadding,
                          right: AppStyle.horizontalPadding,
                        ),
                        child: CustomTextField(
                          controller: _registrationApplicationController
                              .lastNameInEnglishTextEditingController.value,
                          onChangeTextField: (value) {
                            //
                          },
                          label: "Last name in Latin",
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(
                      //     top: 12,
                      //     left: AppStyle.horizontalPadding,
                      //     right: AppStyle.horizontalPadding,
                      //   ),
                      //   child: CustomDropDownPicker(
                      //     controller: _registrationApplicationController
                      //         .sexTextEditingController.value,
                      //     label: "Sex",
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12,
                          left: AppStyle.horizontalPadding,
                          right: AppStyle.horizontalPadding,
                        ),
                        child: CustomTextField(
                          controller: _registrationApplicationController
                              .phoneNumberTextEditingController.value,
                          onChangeTextField: (value) {
                            //
                          },
                          label: "Phone Number",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: AppStyle.horizontalPadding,
                  left: AppStyle.horizontalPadding,
                  right: AppStyle.horizontalPadding,
                ),
                child: CustomButton(
                  onPressed: () {
                    // context.push(AppScreen.loginScreen.path);
                    // debugPrint("Continue");
                    _registrationApplicationController.sexTextEditingController
                        .value.text = "fasdfsadjfasldf";
                  },
                  title: "Continue",
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
