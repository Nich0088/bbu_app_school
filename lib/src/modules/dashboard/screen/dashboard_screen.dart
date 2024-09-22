import 'package:flutter/material.dart';

import 'package:school_app/src/modules/dashboard/models/user_type.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserType.guest.rawString;
    return Scaffold(
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

