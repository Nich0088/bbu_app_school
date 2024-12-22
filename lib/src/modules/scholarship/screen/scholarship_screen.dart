import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/src/common/app_setting.dart';

import '../../../common/widgets/custom_app_bar.dart';
import 'controller/scholarship_controller.dart';

class ScholarshipScreen extends StatelessWidget {
  const ScholarshipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScholarshipController scholarshipController =
        Get.put(ScholarshipController());
    return Scaffold(
      appBar: CustomAppBar(
        context,
        backgroundColor: AppColor.primaryColor,
        isDashboardAppBar: false,
        title: "Scholarship",
        isCenterTitle: true,
        onPressedBack: () {
          context.pop();
        },
      ),
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.asset(
            AppLogo.scholarship,
            fit: BoxFit.fill,
            // height: 150,
            // width: 110,
          ), // Load i
        ),
      ),
    );
  }
}
