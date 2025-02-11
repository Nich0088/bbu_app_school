import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/src/common/widgets/custom_button.dart';

import '../../../common/app_setting.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../check_in/controller/check_In_controller.dart';

class CheckInScreen extends StatelessWidget {
  const CheckInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CheckInController checkInController = Get.put(CheckInController());

    return Scaffold(
      appBar: CustomAppBar(
        context,
        backgroundColor: AppColor.primaryColor,
        appBarType: AppBarType.generalType,
        title: "Check In",
        isCenterTitle: true,
        onPressedBack: () {
          context.pop();
        },
      ),
      backgroundColor: AppColor.primaryColor,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              top: AppStyle.horizontalPadding,
              left: AppStyle.horizontalPadding,
              right: AppStyle.horizontalPadding,
            ),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColor.cardColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                  ),
                  child: Text(
                    'Check In  Information',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: AppColor.textSecondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 12,
                    left: 16,
                    right: 16,
                  ),
                  child: TextLabelWithValue(
                    label: 'Day:',
                    value: 'Monday',
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 12,
                    left: 16,
                    right: 16,
                  ),
                  child: TextLabelWithValue(
                    label: 'Date:',
                    value: '15/9/2024',
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 12,
                    left: 16,
                    right: 16,
                  ),
                  child: TextLabelWithValue(
                    label: 'Time:',
                    value: '7:00 pm',
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  child: TextLabelWithValue(
                    label: 'Subject:',
                    value: 'subject code',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: AppStyle.horizontalPadding,
              left: AppStyle.horizontalPadding,
              right: AppStyle.horizontalPadding,
            ),
            child: CustomButton(
              onPressed: () {
                debugPrint('Check In');
              },
              title: 'Check In',
              buttonColor: AppColor.successColor,
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(
                top: AppStyle.horizontalPadding,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                      right: 10,
                    ),
                    child: Text(
                      'History',
                      overflow: TextOverflow.ellipsis,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: AppColor.textSecondaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: checkInController.checkInList.length,
                      itemBuilder: (context, index) {
                        return AttendantItemWidget(
                          item: checkInController.checkInList[index],
                          isLastItem:
                              index == checkInController.checkInList.length - 1,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AttendantItemWidget extends StatelessWidget {
  const AttendantItemWidget({
    super.key,
    required this.item,
    required this.isLastItem,
  });

  final AttendantItem item;
  final bool isLastItem;

  @override
  Widget build(BuildContext context) {
    double remainingWidth = MediaQuery.of(context).size.width - 122;
    return Container(
      margin: EdgeInsets.only(
        top: AppStyle.horizontalPadding,
        left: AppStyle.horizontalPadding,
        right: AppStyle.horizontalPadding,
        bottom: isLastItem ? AppStyle.horizontalPadding : 0,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
          color: AppColor.cardColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(AppStyle.borderRadius),
          ),
          boxShadow: [
            AppStyle.boxShadow,
          ]),
      child: Row(
        children: [
          Image.asset(
            item.isCheckIn == true
                ? 'assets/attendant/check_in.png'
                : 'assets/attendant/check_out.png',
            width: 30,
            height: 30,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: AppStyle.horizontalPadding),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: remainingWidth,
                child: Text(
                  "item.subjectName sfdasdfasdfjkasdjhkfhkasdfkasdkfakhdfjkhskjd",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppColor.textSecondaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: (remainingWidth * 0.5) - 2,
                    child: Text(
                      'Date: ${item.date}asdfasfasdfasdfasdf',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColor.textSecondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  SizedBox(
                    width: (remainingWidth * 0.5) - 2,
                    child: Text(
                      'Time: ${item.time}asdghfhkasgdfhjkasdkhjfhkj',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColor.textSecondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

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
