import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/src/modules/user_dashboard/model/class_schedule_subject_result.dart';

import '../../../common/app_setting.dart';
import '../../../common/helpers/app_date_formatter.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/loading_scaffold_widget.dart';
import '../../../common/widgets/user_dashboard/class_schedule_subject_item_widget.dart';
import '../controller/student_class_detail_controller.dart';
import '../model/class_schedule_result.dart';

class StudentClassDetailScreen extends StatelessWidget {
  const StudentClassDetailScreen({super.key, this.classScheduleData});

  final ClassScheduleData? classScheduleData;

  @override
  Widget build(BuildContext context) {
    StudentClassDetailController studentClassDetailController =
        Get.put(StudentClassDetailController());

    studentClassDetailController.register(context);
    return _studentClassDetailScreenContent(
      context,
      actionOnInit: () async {
        await studentClassDetailController.getClassScheduleList(
          scheduleId: classScheduleData?.scheduleId,
          studentId: classScheduleData?.studentId,
        );
      },
    );
  }

  Widget _studentClassDetailScreenContent(BuildContext context,
      {required VoidCallback actionOnInit}) {
    StudentClassDetailController studentClassDetailController =
        Get.put(StudentClassDetailController());
    actionOnInit.call();

    return GetBuilder<StudentClassDetailController>(
      builder: (controller) {
        return LoadingScaffoldWidget(
          isShowLoading: controller.isShowLoading,
          appBar: CustomAppBar(
            context,
            backgroundColor: AppColor.primaryColor,
            isDashboardAppBar: false,
            title: "Student class detail",
            isCenterTitle: true,
            onPressedBack: () {
              Get.delete<StudentClassDetailController>();
              context.pop();
            },
          ),
          body: Obx(
            () => Card(
              color: AppColor.cardColor,
              elevation: 4,
              margin: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Container(
                            width: 60,
                            height: 60,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: AppColor.primaryColor,
                            ),
                            child: Text(
                              classScheduleData?.facultyShortName ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        SizedBox(
                          width:
                              (MediaQuery.of(context).size.width - 176) * 0.6,
                          child: Text(
                            classScheduleData?.scheduleShortName ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: Colors.black),
                          ),
                        ),
                        const Spacer(),
                        const SizedBox(width: 20),
                        SizedBox(
                          width:
                              (MediaQuery.of(context).size.width - 176) * 0.4,
                          child: Text(
                            AppDateFormatter.formatDate(
                              pattern: AppDateFormatter.monthCommaDateYear,
                              dateString:
                                  classScheduleData?.startDate?.split('T')[0],
                            ),
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Flexible(
                    child: ListView.builder(
                      itemCount: studentClassDetailController
                                  .classScheduleSubjectResult
                                  .value
                                  .classScheduleSubjectData
                                  ?.isNotEmpty ==
                              true
                          ? studentClassDetailController
                              .classScheduleSubjectResult
                              .value
                              .classScheduleSubjectData
                              ?.length
                          : 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        ClassScheduleSubjectData? item =
                            studentClassDetailController
                                .classScheduleSubjectResult
                                .value
                                .classScheduleSubjectData?[index];
                        if (item == null) {
                          return const SizedBox();
                        }
                        return ClassScheduleSubjectItemWidget(
                          item: item,
                          isNotFirstItem: index > 0,
                          isLastItem: index ==
                              (studentClassDetailController
                                          .classScheduleSubjectResult
                                          .value
                                          .classScheduleSubjectData
                                          ?.length ??
                                      0) -
                                  1,
                          onClick: () {
                            //
                          },
                        );
                      },
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
