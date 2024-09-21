import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

import 'package:school_app/src/constants/app_setting.dart';

class CustomTextField extends StatefulWidget {
  final String? initialValue;
  final String? hintText;
  final String? label;
  final Widget? labelWidget;
  final bool? obscureText;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? suffixIcon;
  final EdgeInsets? padding;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChangeTextField;
  final FormFieldSetter<String>? onSavedTextField;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final int? maxLength;
  final VoidCallback? onEditingComplete;
  final GestureTapCallback? onTap;
  final bool? isValidate;
  final bool? isRequired;
  final TextEditingController? controller;
  final String? validateDescription;
  final Color? validateColor;
  final IconData? validateIcon;
  final TextStyle? validateDescriptionStyle;
  final TextStyle? textFormFieldStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? requiredSignStyle;
  final TextStyle? counterTextStyle;
  final Color? focusedBorderColor;
  final bool? isShowMaxLength;
  final FocusNode? focusNode;
  const CustomTextField({
    super.key,
    this.hintText,
    this.padding,
    this.controller,
    this.label,
    this.labelWidget,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.isRequired = false,
    this.prefix,
    this.suffix,
    this.isValidate = false,
    this.inputFormatters,
    this.onEditingComplete,
    this.validator,
    this.onTap,
    this.onChangeTextField,
    this.onSavedTextField,
    this.keyboardType,
    this.maxLength,
    this.initialValue,
    this.validateDescription,
    this.validateColor = const Color(0xFFFF4444),
    this.validateIcon,
    this.validateDescriptionStyle,
    this.textFormFieldStyle,
    this.hintStyle,
    this.labelStyle,
    this.requiredSignStyle,
    this.focusedBorderColor,
    this.counterTextStyle,
    this.isShowMaxLength = false,
    this.focusNode,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isNull = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          maxLength: widget.maxLength,
          initialValue: widget.initialValue,
          controller: widget.controller,
          style: widget.textFormFieldStyle ??
              Theme.of(context).textTheme.bodyMedium,
          scrollPadding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          keyboardType: widget.keyboardType,
          inputFormatters: widget.inputFormatters,
          onEditingComplete: widget.onEditingComplete,
          validator: widget.validator,
          obscureText: widget.obscureText ?? false,
          onTap: widget.onTap,
          focusNode: widget.focusNode,
          decoration: InputDecoration(
            filled: true,
            fillColor: widget.controller?.text == ''
                ? const Color(0xffF2F2F2)
                : AppColor.cardColor,
            contentPadding: (() {
              if (widget.padding != null) {
                return widget.padding;
              } else {
                return EdgeInsets.only(
                  top: 24,
                  left: 16,
                  bottom: widget.prefixIcon == null ? 0 : 12,
                );
              }
            }()),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0xFFFF4444),
              ),
              borderRadius: BorderRadius.circular(AppStyle.borderRadius),
            ),
            hintText: widget.hintText,
            hintStyle:
                widget.hintStyle ?? Theme.of(context).textTheme.bodyLarge,
            label: (() {
              if (widget.labelWidget != null) {
                return widget.labelWidget;
              } else {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    color: widget.controller?.text == ''
                        ? const Color(0xffF2F2F2)
                        : AppColor.cardColor,
                  ),
                  width: widget.isRequired == true
                      ? ((widget.label?.length ?? 0) * 12)
                      : (widget.label?.length ?? 0) * 8,
                  child: Row(
                    children: [
                      Text(
                        widget.label != null ? '${widget.label}' : '',
                        style: widget.labelStyle ??
                            Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppColor.successColor,
                                ),
                      ),
                      if (widget.isRequired == true)
                        Text(
                          ' *',
                          style: widget.requiredSignStyle ??
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: widget.validateColor ??
                                        const Color(0xFFFF4444),
                                  ),
                        ),
                    ],
                  ),
                );
              }
            }()),
            labelStyle: widget.labelStyle ??
                Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColor.primaryColor,
                    ),
            prefix: widget.prefix,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            suffix: widget.suffix,
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  AppStyle.borderRadius,
                ),
              ),
              borderSide: BorderSide(
                width: 1,
                color: widget.isValidate == false
                    ? isNull == true
                        ? const Color(0xffF2F2F2)
                        : const Color(0xffE0E0E0)
                    : widget.validateColor ?? const Color(0xFFFF4444),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(
                width: 1.5,
                color: widget.focusedBorderColor ?? AppColor.primaryColor,
              ),
            ),
          ),
          onChanged: (value) {
            if (value.isEmpty) {
              setState(() {
                isNull = true;
              });
            } else {
              setState(() {
                isNull = false;
              });
            }
            widget.onChangeTextField?.call(value);
          },
          onSaved: widget.onSavedTextField,
        ),
        if (widget.isValidate == true || widget.maxLength != null)
          Padding(
            padding: const EdgeInsets.only(
              left: 5,
              top: 5,
            ),
            child: Row(
              children: [
                (() {
                  if (widget.isValidate == true) {
                    if (widget.validateIcon != null) {
                      return Icon(
                        widget.validateIcon,
                        size: 15,
                        color: widget.validateColor,
                      );
                    } else {
                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationZ(math.pi),
                        child: Icon(
                          (() {
                            if (widget.validateIcon != null) {
                              return widget.validateIcon;
                            } else {
                              return Icons.info_rounded;
                            }
                          }()),
                          size: 15,
                          color: widget.validateColor,
                        ),
                      );
                    }
                  } else {
                    return const Spacer();
                  }
                }()),
                SizedBox(
                  width: widget.isValidate == true ? 9 : 0,
                ),
                if (widget.isValidate == true)
                  Expanded(
                    child: Text(
                      widget.validateDescription != null
                          ? widget.validateDescription!
                          : "",
                      style: widget.validateDescriptionStyle ??
                          Theme.of(context).textTheme.displayLarge!.copyWith(
                                fontSize: 13,
                                color: widget.validateColor,
                                fontWeight: FontWeight.normal,
                              ),
                    ),
                  ),
                if (widget.maxLength != null && widget.isShowMaxLength!)
                  Text(
                    '${widget.controller!.text.length} / ${widget.maxLength}',
                    style: widget.counterTextStyle ??
                        Theme.of(context).textTheme.displayLarge!.copyWith(
                              fontSize: 14,
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
