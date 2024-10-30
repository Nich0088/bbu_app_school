import 'package:flutter/material.dart';

class AppColor {
  static const primaryColor = Color(0xFF2E3192);
  static const secondaryColor = Color(0xFF6610F2);
  static const successColor = Color(0xFF0CCE6B);
  static const errorColor = Color(0xFFF02D3A);
  static const warningColor = Color(0xFFE3B505);
  static const infoColor = Color(0xFF78C3FB);
  static const textPrimaryColor = Color(0xFFFFFFFF);
  static const textSecondaryColor = Color(0x80000000);
  static const textTertiaryColor = Color(0xFF9586A8);
  static const cardColor = Color(0xFFFAFDFF);
  static const disableColor = Color(0xFFB8C5D0);
  static const unselectedColor = Color(0xFFF2F2F2);
  static const background = Color(0x20FFFFFF);
}

class AppLogo {
  static const appLogo = "assets/app_logo.png";
  static const scholarship = "assets/bbu_scholarship.png";
  static const events = "assets/events1.png";
}

class AppStyle {
  static final boxShadow = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    blurRadius: 10,
    spreadRadius: 0,
    offset: const Offset(0, 1),
  );
  static const double borderRadius = 12;
  static const double horizontalPadding = 20;
}
