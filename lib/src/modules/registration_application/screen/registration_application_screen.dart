// import 'dart:io';
//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:school_app/src/common/widgets/custom_drop_down_picker.dart';
// import 'package:school_app/src/common/widgets/loading_scaffold_widget.dart';
//
// import '../../../common/app_setting.dart';
// import '../../../common/model/custom_drop_down_menu_item.dart';
// import '../../../common/widgets/custom_app_bar.dart';
// import '../../../common/widgets/custom_button.dart';
// import '../../../common/widgets/custom_text_field.dart';
// import '../controller/registration_application_controller.dart';
//
// class RegistrationApplicationScreen extends StatefulWidget {
//   const RegistrationApplicationScreen({super.key});
//
//   @override
//   State<RegistrationApplicationScreen> createState() =>
//       _RegistrationApplicationScreenState();
// }
//
// class _RegistrationApplicationScreenState
//     extends State<RegistrationApplicationScreen> {
//   final RegistrationApplicationController _registrationApplicationController =
//       Get.put(RegistrationApplicationController());
//   final FocusNode _firstNameInKhmerFocusNode = FocusNode();
//   final FocusNode _lastNameInKhmerFocusNode = FocusNode();
//   final FocusNode _firstNameInLatinFocusNode = FocusNode();
//   final FocusNode _lastNameInLatinFocusNode = FocusNode();
//   final FocusNode _phoneNumberFocusNode = FocusNode();
//
//   final ImagePicker _picker = ImagePicker();
//
//   Future<void> _getImage() async {
//     final XFile? pickedFile =
//         await _picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       _registrationApplicationController.selectedImage.value =
//           File(pickedFile.path);
//     }
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     Get.delete<RegistrationApplicationController>();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _registrationApplicationController.register(context);
//
//     return GetBuilder<RegistrationApplicationController>(
//       builder: (controller) => LoadingScaffoldWidget(
//         isShowLoading: controller.isShowLoading,
//         appBar: CustomAppBar(
//           context,
//           backgroundColor: AppColor.primaryColor,
//           appBarType: AppBarType.generalType,
//           title: context.tr('registration_application'),
//           isCenterTitle: true,
//           onPressedBack: () {
//             context.pop();
//           },
//         ),
//         backgroundColor: Colors.white,
//         body: Stack(
//           children: [
//             Align(
//               alignment: Alignment.center,
//               child: Opacity(
//                 opacity: 0.7,
//                 child: Image.asset(
//                   AppLogo.appLogo,
//                   height: MediaQuery.of(context).size.height * 0.3,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Obx(
//               () => GestureDetector(
//                 onTap: () {
//                   _firstNameInKhmerFocusNode.unfocus();
//                   _lastNameInKhmerFocusNode.unfocus();
//                   _firstNameInLatinFocusNode.unfocus();
//                   _lastNameInLatinFocusNode.unfocus();
//                   _phoneNumberFocusNode.unfocus();
//                 },
//                 child: Column(
//                   children: [
//                     Expanded(
//                       child: SingleChildScrollView(
//                         child: Column(
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                 top: AppStyle.horizontalPadding,
//                                 right: AppStyle.horizontalPadding,
//                                 left: AppStyle.horizontalPadding,
//                               ),
//                               child: GestureDetector(
//                                 onTap: () async {
//                                   await _getImage();
//                                 },
//                                 child: Stack(
//                                   children: [
//                                     ClipRRect(
//                                       borderRadius: const BorderRadius.all(
//                                         Radius.circular(8),
//                                       ),
//                                       child: _registrationApplicationController
//                                                   .selectedImage.value !=
//                                               null
//                                           ? Image.file(
//                                               _registrationApplicationController
//                                                   .selectedImage.value!,
//                                               width: 200,
//                                               height: 200,
//                                               fit: BoxFit.cover,
//                                             )
//                                           : Image.asset(
//                                               'assets/registration_application/user.png',
//                                               width: 200,
//                                               height: 200,
//                                               fit: BoxFit.cover,
//                                             ),
//                                     ),
//                                     Positioned(
//                                       bottom: 4,
//                                       right: 4,
//                                       child: Container(
//                                         padding: const EdgeInsets.all(8),
//                                         decoration: const BoxDecoration(
//                                           color: Colors.blue,
//                                           shape: BoxShape.circle,
//                                         ),
//                                         child: const Icon(
//                                           Icons.edit,
//                                           size: 24.0,
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                 top: AppStyle.horizontalPadding,
//                                 left: AppStyle.horizontalPadding,
//                                 right: AppStyle.horizontalPadding,
//                               ),
//                               child: CustomTextField(
//                                 focusNode: _firstNameInKhmerFocusNode,
//                                 controller: _registrationApplicationController
//                                     .firstNameInKhmerTextEditingController
//                                     .value,
//                                 onChangeTextField: (value) {
//                                   //
//                                 },
//                                 // label: context.tr('first_name_kh'),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                 top: 16,
//                                 left: AppStyle.horizontalPadding,
//                                 right: AppStyle.horizontalPadding,
//                               ),
//                               child: CustomTextField(
//                                 focusNode: _lastNameInKhmerFocusNode,
//                                 controller: _registrationApplicationController
//                                     .lastNameInKhmerTextEditingController.value,
//                                 onChangeTextField: (value) {
//                                   //
//                                 },
//                                 label: "Last name in Khmer",
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                 top: 16,
//                                 left: AppStyle.horizontalPadding,
//                                 right: AppStyle.horizontalPadding,
//                               ),
//                               child: CustomTextField(
//                                 focusNode: _firstNameInLatinFocusNode,
//                                 controller: _registrationApplicationController
//                                     .firstNameInEnglishTextEditingController
//                                     .value,
//                                 onChangeTextField: (value) {
//                                   //
//                                 },
//                                 label: "First name in Latin",
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                 top: 16,
//                                 left: AppStyle.horizontalPadding,
//                                 right: AppStyle.horizontalPadding,
//                               ),
//                               child: CustomTextField(
//                                 focusNode: _lastNameInLatinFocusNode,
//                                 controller: _registrationApplicationController
//                                     .lastNameInEnglishTextEditingController
//                                     .value,
//                                 onChangeTextField: (value) {
//                                   //
//                                 },
//                                 label: "Last name in Latin",
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                 top: 16,
//                                 left: AppStyle.horizontalPadding,
//                                 right: AppStyle.horizontalPadding,
//                               ),
//                               child: CustomDropDownPicker(
//                                 controller: _registrationApplicationController
//                                     .sexTextEditingController.value,
//                                 label: "Sex",
//                                 onSelected: (item) {
//                                   _registrationApplicationController
//                                       .sexTextEditingController
//                                       .value
//                                       .text = item?.title ?? '';
//                                 },
//                                 dropDownMenuEntryList:
//                                     _registrationApplicationController.sexesList
//                                         .map((item) => DropdownMenuEntry<
//                                                 CustomDropDownMenuItem>(
//                                               value: item,
//                                               label: item.title,
//                                             ))
//                                         .toList(),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                 top: 16,
//                                 left: AppStyle.horizontalPadding,
//                                 right: AppStyle.horizontalPadding,
//                               ),
//                               child: CustomDatePicker(
//                                 label: 'Date of birth',
//                                 controller: _registrationApplicationController
//                                     .dobTextEditingController.value,
//                                 onDateSelected: (date) {
//                                   _registrationApplicationController
//                                       .dobTextEditingController
//                                       .value
//                                       .text = date;
//                                 },
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                 top: 16,
//                                 left: AppStyle.horizontalPadding,
//                                 right: AppStyle.horizontalPadding,
//                               ),
//                               child: CustomTextField(
//                                 focusNode: _phoneNumberFocusNode,
//                                 controller: _registrationApplicationController
//                                     .phoneNumberTextEditingController.value,
//                                 onChangeTextField: (value) {
//                                   //
//                                 },
//                                 label: "Phone Number",
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                 top: 16,
//                                 left: AppStyle.horizontalPadding,
//                                 right: AppStyle.horizontalPadding,
//                               ),
//                               child: CustomDropDownPicker(
//                                 controller: _registrationApplicationController
//                                     .placeOfBirthTextEditingController.value,
//                                 label: "Place of birth",
//                                 onSelected: (item) {
//                                   _registrationApplicationController
//                                       .placeOfBirthTextEditingController
//                                       .value
//                                       .text = item?.title ?? '';
//                                 },
//                                 dropDownMenuEntryList:
//                                     _registrationApplicationController
//                                         .placeOfBirthList
//                                         .map((item) => DropdownMenuEntry<
//                                                 CustomDropDownMenuItem>(
//                                               value: item,
//                                               label: item.title,
//                                             ))
//                                         .toList(),
//                               ),
//                             ),
//                             const SizedBox(
//                               height: AppStyle.horizontalPadding,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         bottom: AppStyle.horizontalPadding,
//                         left: AppStyle.horizontalPadding,
//                         right: AppStyle.horizontalPadding,
//                       ),
//                       child: CustomButton(
//                         onPressed: () {
//                           debugPrint("Continue");
//                         },
//                         title: "Continue",
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CustomDatePicker extends StatefulWidget {
//   final String? label;
//   final TextStyle? labelStyle;
//   final TextStyle? textFormFieldStyle;
//   final TextEditingController? controller;
//   final EdgeInsets? padding;
//   final ValueChanged<String>? onDateSelected;
//
//   const CustomDatePicker({
//     super.key,
//     this.label,
//     this.labelStyle,
//     this.controller,
//     this.padding,
//     this.textFormFieldStyle,
//     this.onDateSelected,
//   });
//
//   @override
//   State<CustomDatePicker> createState() => _CustomDatePickerState();
// }
//
// class _CustomDatePickerState extends State<CustomDatePicker> {
//   Future<void> _selectDate(BuildContext context) async {
//     int firstDate = DateTime.now().year - 70;
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(firstDate),
//       lastDate: DateTime.now(),
//     );
//     if (pickedDate != null) {
//       widget.onDateSelected?.call(pickedDate.toString());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           widget.label ?? '',
//           style: widget.labelStyle ??
//               Theme.of(context).textTheme.titleLarge?.copyWith(
//                     color: AppColor.textTertiaryColor,
//                   ),
//         ),
//         const SizedBox(height: 4),
//         TextFormField(
//           controller: widget.controller,
//           readOnly: true,
//           showCursor: false,
//           onTap: () async {
//             await _selectDate(context);
//           },
//           style: widget.textFormFieldStyle ??
//               Theme.of(context)
//                   .textTheme
//                   .bodyLarge
//                   ?.copyWith(color: AppColor.textSecondaryColor),
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: widget.controller?.text == ''
//                 ? const Color(0xffF2F2F2)
//                 : AppColor.cardColor,
//             contentPadding: (() {
//               if (widget.padding != null) {
//                 return widget.padding;
//               } else {
//                 return const EdgeInsets.only(
//                   top: 24,
//                   left: 16,
//                   right: 8,
//                 );
//               }
//             }()),
//             border: OutlineInputBorder(
//               borderSide: const BorderSide(
//                 color: Color(0xFFFF4444),
//               ),
//               borderRadius: BorderRadius.circular(AppStyle.borderRadius),
//             ),
//             suffix: const Icon(
//               Icons.calendar_month,
//               color: AppColor.textSecondaryColor,
//               size: 16,
//             ),
//             counter: const Offstage(),
//             enabledBorder: const OutlineInputBorder(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(
//                   AppStyle.borderRadius,
//                 ),
//               ),
//               borderSide: BorderSide(
//                 width: 1,
//                 // color: widget.isShowError == false
//                 //     ? isNull == true
//                 //         ? const Color(0xffF2F2F2)
//                 //         : const Color(0xffE0E0E0)
//                 //     : widget.validateColor ?? const Color(0xFFFF4444),
//                 color: Color(0xffF2F2F2),
//               ),
//             ),
//             focusedBorder: const OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//               borderSide: BorderSide(
//                 width: 1.5,
//                 color: AppColor.primaryColor,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
