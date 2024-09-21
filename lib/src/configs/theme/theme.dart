import 'package:flutter/material.dart';
import '../../constants/app_setting.dart';

ThemeData themeData = ThemeData(
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: AppColor.textPrimaryColor),
    backgroundColor: Colors.white,
    elevation: 5,
    shadowColor: Color(0x1A000000),
    titleTextStyle: TextStyle(
      fontFamily: 'sourcesanspro',
      fontWeight: FontWeight.normal,
      fontSize: 16,
      color: AppColor.textPrimaryColor,
    ),
  ),
  iconTheme: const IconThemeData(color: AppColor.textPrimaryColor),
  primaryColor: AppColor.primaryColor,
  cardColor: AppColor.cardColor,
  disabledColor: AppColor.textPrimaryColor,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'sourcesanspro',
      fontWeight: FontWeight.normal,
      fontSize: 26,
      color: AppColor.textPrimaryColor,
    ),
    displayMedium: TextStyle(
      fontFamily: 'sourcesanspro',
      fontWeight: FontWeight.normal,
      fontSize: 24,
      color: AppColor.textPrimaryColor,
    ),
    displaySmall: TextStyle(
      fontFamily: 'sourcesanspro',
      fontWeight: FontWeight.normal,
      fontSize: 22,
      color: AppColor.textPrimaryColor,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'sourcesanspro',
      fontWeight: FontWeight.normal,
      fontSize: 20,
      color: AppColor.textPrimaryColor,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'sourcesanspro',
      fontWeight: FontWeight.normal,
      fontSize: 18,
      color: AppColor.textPrimaryColor,
    ),
    titleLarge: TextStyle(
      fontFamily: 'sourcesanspro',
      fontWeight: FontWeight.normal,
      fontSize: 16,
      color: AppColor.textPrimaryColor,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'sourcesanspro',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: AppColor.textPrimaryColor,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'sourcesanspro',
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: AppColor.textPrimaryColor,
    ),
    bodySmall: TextStyle(
      fontFamily: 'sourcesanspro',
      fontWeight: FontWeight.w400,
      fontSize: 10,
      color: AppColor.textPrimaryColor,
    ),
  ),
);
