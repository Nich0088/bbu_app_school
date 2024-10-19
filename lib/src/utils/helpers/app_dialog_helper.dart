import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/src/constants/app_setting.dart';
import 'package:school_app/src/utils/widgets/custom_button.dart';

class AppDialogHelper {
  void showErrorDialog(
    BuildContext context, {
    String title = "Message",
    required String errorMessage,
    required String errorCode,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Padding(
            padding: const EdgeInsets.all(AppStyle.horizontalPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset(
                  "assets/error_vector.svg",
                  height: 96,
                ),
                const SizedBox(height: 12),
                Text(
                  "$errorMessage ($errorCode)",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColor.textSecondaryColor,
                      ),
                ),
                const SizedBox(height: 24),
                CustomButton(
                  onPressed: () {
                    context.pop();
                  },
                  title: "Ok",
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
