import 'package:flutter/material.dart';

import '../../../../common/widgets/custom_app_bar.dart';
import '../../../../constants/app_setting.dart';

class CampusScreen extends StatefulWidget {
  const CampusScreen({super.key});

  @override
  State<CampusScreen> createState() => _CampusScreenState();
}

class _CampusScreenState extends State<CampusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context,
        backgroundColor: AppColor.primaryColor,
        isDashboardAppBar: false,
        title: "Campus",
        isCenterTitle: true,
      ),
    );
  }
}
