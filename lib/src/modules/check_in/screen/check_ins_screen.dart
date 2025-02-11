import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../common/app_setting.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_button.dart';
import '../controller/check_in_controller.dart';

class CheckInsScreen extends StatelessWidget {
  const CheckInsScreen({super.key});

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
                    value: '15/12/2024',
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
                    value: '8:30 pm',
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  child: TextLabelWithValue(
                    label: 'Subject:',
                    value: '5143',
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
              title: 'Check Out',
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
    double remainingWidth = MediaQuery.of(context).size.width - 124;
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
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(AppStyle.borderRadius),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12, // Shadow color
            offset: Offset(0, 4), // Shadow position (x, y)
            blurRadius: 6.0, // Blur effect
            spreadRadius: 1.0, // Spread effect
          ),
        ],
        border: Border.all(color: Colors.white70, width: 1.0),
        // border: Border.all(
        //   color: Colors.white24, // Border color
        //   width: 1.0, // Border width
        // ),
      ),
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
                  "Subject Name: Core English ",
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
                      'Date: ${item.date}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColor.textSecondaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  const SizedBox(width: 48),
                  SizedBox(
                    // width: (remainingWidth * 0.5) - 2,
                    child: Text(
                      'Time: ${item.time}',
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
