import 'package:flutter/material.dart';
import 'package:school_app/src/constants/app_setting.dart';
import 'package:school_app/src/modules/dashboard/models/user_type.dart';
import 'package:school_app/src/utils/widgets/custom_app_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key, this.userType});
  final UserType? userType;

  @override
  Widget build(BuildContext context) {
    switch (userType) {
      case null:
        return const SizedBox();
      case UserType.loggedInUser:
        return _setupViewForLoggedInUser(context);
      case UserType.guest:
        return _setupViewForGuestUser(context);
    }
  }

  Widget _setupViewForLoggedInUser(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: CustomAppBar(
        context,
        backgroundColor: AppColor.primaryColor,
        isDashboardAppBar: true,
        username: "Dek Somdel",
        imageUrl:
            "https://www.nmspacemuseum.org/wp-content/uploads/2019/03/Elon_Musk.jpg",
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }

  Widget _setupViewForGuestUser(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.errorColor,
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
