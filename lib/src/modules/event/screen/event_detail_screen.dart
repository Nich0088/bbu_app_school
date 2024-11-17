import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../constants/app_setting.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key, this.description});

  final String? description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context,
        backgroundColor: AppColor.primaryColor,
        isDashboardAppBar: false,
        title: "Detail news & Event",
        isCenterTitle: true,
        onPressedBack: () {
          context.pop();
        },
      ),
      body: description != null ? Html(data: description) : const SizedBox(),
    );
  }
}
