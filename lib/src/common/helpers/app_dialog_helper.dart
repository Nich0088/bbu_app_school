import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/src/common/app_setting.dart';

import '../widgets/custom_button.dart';

class AppDialogHelper {
  final BuildContext _context;

  AppDialogHelper({required BuildContext context}) : _context = context;

  void showErrorDialog({
    String title = "Message",
    required String errorMessage,
    required String errorCode,
  }) {
    showDialog(
      context: _context,
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

  void showSuccessDialog({
    String title = "Message",
    required String message,
  }) {
    showDialog(
      context: _context,
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
                  "assets/attendant/success_vector.svg",
                  height: 96,
                ),
                const SizedBox(height: 12),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColor.textSecondaryColor,
                      ),
                ),
                const SizedBox(height: 24),
                CustomButton(
                  buttonColor: AppColor.successColor,
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
