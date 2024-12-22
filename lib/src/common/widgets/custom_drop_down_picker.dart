import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:school_app/src/common/model/custom_drop_down_menu_item.dart';

import '../app_setting.dart';

class CustomDropDownPicker extends StatelessWidget {
  final String? label;
  final TextStyle? labelTextStyle;
  final TextEditingController? controller;
  final ValueChanged<CustomDropDownMenuItem?>? onSelected;
  final List<DropdownMenuEntry<CustomDropDownMenuItem>> dropDownMenuEntryList;
  final bool? isShowError;
  final String? errorDescription;
  final TextStyle? validateDescriptionStyle;

  const CustomDropDownPicker({
    super.key,
    this.label,
    this.labelTextStyle,
    this.controller,
    this.onSelected,
    required this.dropDownMenuEntryList,
    this.isShowError = false,
    this.errorDescription,
    this.validateDescriptionStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label ?? '',
          style: labelTextStyle ??
              Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColor.textTertiaryColor,
                  ),
        ),
        const SizedBox(height: 4),
        DropdownMenu<CustomDropDownMenuItem>(
          width: double.infinity,
          controller: controller,
          menuHeight: 200,
          menuStyle: MenuStyle(
            minimumSize: const WidgetStatePropertyAll(Size(200, 100)),
            maximumSize: const WidgetStatePropertyAll(Size(200, 100)),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppStyle.borderRadius),
              ),
            ),
            elevation: const WidgetStatePropertyAll(2),
          ),
          textStyle: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: AppColor.textSecondaryColor),
          inputDecorationTheme: InputDecorationTheme(
            suffixIconColor: AppColor.textSecondaryColor,
            fillColor: controller?.text == ''
                ? const Color(0xffF2F2F2)
                : AppColor.cardColor,
            filled: true,
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFFFF4444),
              ),
              borderRadius: BorderRadius.circular(AppStyle.borderRadius),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  AppStyle.borderRadius,
                ),
              ),
              borderSide: BorderSide(
                width: 1.5,
                color: AppColor.primaryColor,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                width: 1.5,
                color: AppColor.primaryColor,
              ),
            ),
          ),
          onSelected: (value) {
            onSelected?.call(value);
          },
          dropdownMenuEntries: dropDownMenuEntryList,
        ),
        if (isShowError == true)
          Padding(
            padding: const EdgeInsets.only(
              left: 5,
              top: 5,
            ),
            child: Row(
              children: [
                (() {
                  if (isShowError == true) {
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationZ(math.pi),
                      child: Icon(
                        (() {
                          return Icons.info_rounded;
                        }()),
                        size: 15,
                        color: const Color(0xFFFF4444),
                      ),
                    );
                  } else {
                    return const Spacer();
                  }
                }()),
                SizedBox(
                  width: isShowError == true ? 8 : 0,
                ),
                if (isShowError == true)
                  Text(
                    errorDescription != null ? "$errorDescription" : "",
                    style: validateDescriptionStyle ??
                        Theme.of(context).textTheme.displayLarge!.copyWith(
                              fontSize: 13,
                              color: const Color(0xFFFF4444),
                              fontWeight: FontWeight.normal,
                            ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
