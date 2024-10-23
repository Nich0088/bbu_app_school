import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/custom_app_bar.dart';
import '../../../../constants/app_setting.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context,
        backgroundColor: AppColor.primaryColor,
        isDashboardAppBar: false,
        title: "Video",
        isCenterTitle: true,
        onPressedBack: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            height: 70,
            decoration: BoxDecoration(
                color: AppColor.textPrimaryColor, // Background color
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: AppColor.textSecondaryColor.withOpacity(0.1),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    blurRadius: 25,
                    spreadRadius: -5,
                    offset: Offset(
                      0,
                      20,
                    ),
                  ),
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.04),
                    blurRadius: 10,
                    spreadRadius: -5,
                    offset: Offset(
                      0,
                      10,
                    ),
                  ),
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
                  child: Text(
                    'BBU TVC Spot',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
