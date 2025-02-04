import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/src/common/widgets/custom_button.dart';
import 'package:school_app/src/modules/user_dashboard/controller/attendant_controller.dart';
import 'package:school_app/src/modules/user_dashboard/model/attendant_screen_data.dart';
import 'package:school_app/src/modules/user_dashboard/model/check_in_and_out_history_result.dart';

import '../../../common/app_setting.dart';
import '../../../common/helpers/app_date_formatter.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/loading_container_widget.dart';

class AttendantScreen extends StatelessWidget {
  const AttendantScreen({super.key, this.attendantScreenData});

  final AttendantScreenData? attendantScreenData;

  @override
  Widget build(BuildContext context) {
    AttendantController attendantController = Get.put(AttendantController());

    attendantController.register(context);
    attendantController.setAttendantScreenData(attendantScreenData);

    return GetBuilder<AttendantController>(
      builder: (controller) {
        return LoadingContainerWidget(
          isShowLoading: controller.isShowLoading,
          child: Scaffold(
            appBar: CustomAppBar(
              context,
              backgroundColor: AppColor.primaryColor,
              isDashboardAppBar: false,
              title: "Attendant",
              isCenterTitle: true,
              onPressedBack: () {
                Get.delete<AttendantController>();
                context.pop();
              },
            ),
            backgroundColor: AppColor.primaryColor,
            body: Obx(
              () => Column(
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
                            'Attendant  Information',
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  color: AppColor.textSecondaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 12,
                            left: 16,
                            right: 16,
                          ),
                          child: TextLabelWithValue(
                            label: 'Day:',
                            value:
                                '${attendantController.attendantScreenData.value.classScheduleSubjectData?.dayname}',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 12,
                            left: 16,
                            right: 16,
                          ),
                          child: TextLabelWithValue(
                            label: 'Date:',
                            value: AppDateFormatter.formatDate(
                              pattern: AppDateFormatter.monthCommaDateYear,
                              dateString: attendantController
                                  .attendantScreenData
                                  .value
                                  .classScheduleSubjectData
                                  ?.startDate
                                  ?.split('T')[0],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 12,
                            left: 16,
                            right: 16,
                          ),
                          child: TextLabelWithValue(
                            label: 'Time:',
                            value:
                                '${attendantController.attendantScreenData.value.classScheduleSubjectData?.timeGeneral}',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          child: TextLabelWithValue(
                            label: 'Subject:',
                            value:
                                '${attendantController.attendantScreenData.value.classScheduleSubjectData?.subjectCode}',
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
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    color: AppColor.textSecondaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          if (attendantController.checkInAndOutHistoryResult
                                  .value.checkInAndOutHistoryDataList !=
                              null)
                            Expanded(
                              child: ListView.builder(
                                itemCount: attendantController
                                    .checkInAndOutHistoryResult
                                    .value
                                    .checkInAndOutHistoryDataList
                                    ?.length,
                                itemBuilder: (context, index) {
                                  var checkInAndOutHistoryDataItem =
                                      attendantController
                                          .checkInAndOutHistoryResult
                                          .value
                                          .checkInAndOutHistoryDataList?[index];
                                  if (checkInAndOutHistoryDataItem == null) {
                                    return const SizedBox();
                                  }

                                  return AttendantItemWidget(
                                    item: checkInAndOutHistoryDataItem,
                                    isLastItem: index ==
                                        (attendantController
                                                    .checkInAndOutHistoryResult
                                                    .value
                                                    .checkInAndOutHistoryDataList
                                                    ?.length ??
                                                0) -
                                            1,
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
            ),
          ),
        );
      },
    );
  }
}

class AttendantItemWidget extends StatelessWidget {
  const AttendantItemWidget({
    super.key,
    required this.item,
    required this.isLastItem,
  });

  final CheckInAndOutHistoryData item;
  final bool isLastItem;

  @override
  Widget build(BuildContext context) {
    double remainingWidth = MediaQuery.of(context).size.width - 122;
    String time = '';
    if (item.status == null) {
      time = '';
    } else if (item.status?.toLowerCase() == 'in') {
      time = '${item.checkInDate}';
    } else if (item.status?.toLowerCase() == 'out') {
      time = '${item.checkOutDate}';
    }
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
            item.status?.toLowerCase() == 'in'
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
                  item.subjectId ?? '',
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
                      'Date: $time',
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
                      'Time: $time',
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
