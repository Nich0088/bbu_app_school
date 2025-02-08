import 'package:flutter/material.dart';

import '../../app_setting.dart';

class TextLabelWithValue extends StatelessWidget {
  const TextLabelWithValue({
    super.key,
    this.label,
    this.value,
    this.labelStyle,
    this.valueStyle,
  });

  final String? label;
  final String? value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label ?? '',
          style: labelStyle ??
              Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColor.textSecondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
        ),
        Text(
          value ?? '',
          style: valueStyle ??
              Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColor.textSecondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
        ),
      ],
    );
  }
}
