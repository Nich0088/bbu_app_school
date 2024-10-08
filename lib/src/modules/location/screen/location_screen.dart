import 'package:flutter/material.dart';
import 'package:school_app/src/constants/app_setting.dart';
import 'package:school_app/src/utils/widgets/custom_app_bar.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context,
        backgroundColor: AppColor.primaryColor,
        isDashboardAppBar: false,
        title: "Location",
        isCenterTitle: true,
      ),
    );
  }
}
