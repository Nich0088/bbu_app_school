import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/src/common/widgets/custom_button.dart';
import 'package:school_app/src/modules/user_dashboard/controller/attendant_controller.dart';
import 'package:school_app/src/modules/user_dashboard/model/attendant_screen_data.dart';

import '../../../common/app_setting.dart';
import '../../../common/helpers/app_date_formatter.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/loading_container_widget.dart';
import '../../../common/widgets/user_dashboard/attendant_item_widget.dart';
import '../../../common/widgets/user_dashboard/text_label_with_value.dart';

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
                            value: AppDateFormatter.formatDateWithLocalTimeZone(
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
                      onPressed: () async {
                        await attendantController.checkIn(
                          studentId: attendantScreenData?.studentId,
                          scheduleId: attendantScreenData
                              ?.classScheduleSubjectData?.scheduleID
                              ?.toString(),
                          subjId: attendantScreenData
                              ?.classScheduleSubjectData?.subjID
                              ?.toString(),
                        );
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
                          Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                await attendantController
                                    .getCheckInAndOutHistory(
                                  studentId: attendantController
                                      .attendantScreenData.value.studentId,
                                  scheduleId: attendantController
                                      .attendantScreenData
                                      .value
                                      .classScheduleSubjectData
                                      ?.scheduleID
                                      ?.toString(),
                                  subjId: attendantController
                                      .attendantScreenData
                                      .value
                                      .classScheduleSubjectData
                                      ?.subjID
                                      ?.toString(),
                                );
                              },
                              child: ListView.builder(
                                itemCount: attendantController
                                    .checkInAndOutList.length,
                                itemBuilder: (context, index) {
                                  var checkInAndOutHistoryDataItem =
                                      attendantController
                                          .checkInAndOutList[index];

                                  return AttendantItemWidget(
                                    item: checkInAndOutHistoryDataItem,
                                    isLastItem: index ==
                                        (attendantController
                                                .checkInAndOutList.length -
                                            1),
                                    onClick: () async {
                                      if (checkInAndOutHistoryDataItem
                                              .checkStatus
                                              ?.toLowerCase() ==
                                          'in') {
                                        await attendantController.checkOut(
                                          studentId:
                                              attendantScreenData?.studentId,
                                          scheduleId: attendantScreenData
                                              ?.classScheduleSubjectData
                                              ?.scheduleID
                                              ?.toString(),
                                          subjId: attendantScreenData
                                              ?.classScheduleSubjectData?.subjID
                                              ?.toString(),
                                          checkInId:
                                              checkInAndOutHistoryDataItem.id
                                                  ?.toString(),
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
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
