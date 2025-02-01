import 'package:flutter/material.dart';

import '../../../modules/user_dashboard/model/class_schedule_subject_result.dart';
import '../../app_setting.dart';

class ClassScheduleSubjectItemWidget extends StatelessWidget {
  const ClassScheduleSubjectItemWidget({
    super.key,
    required this.item,
    required this.isNotFirstItem,
    required this.onClick,
    required this.isLastItem,
  });

  final ClassScheduleSubjectData item;
  final bool isNotFirstItem;
  final bool isLastItem;
  final GestureTapCallback onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick.call();
      },
      child: Card(
        margin: EdgeInsets.only(
          top: isNotFirstItem ? 16 : 0,
          bottom: isLastItem ? 20 : 0,
          left: 20,
          right: 20,
        ),
        elevation: 4,
        color: AppColor.cardColor,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Image.asset(
                'assets/student_class_detail/menu.png',
                width: 10,
                fit: BoxFit.fill,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  item.subjectNameen ?? '',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.black),
                ),
              ),
              Text(
                item.dayname ?? '',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.black),
              ),
              const SizedBox(width: 4),
              Image.asset(
                'assets/student_class_detail/setting.png',
                width: 16,
                fit: BoxFit.fill,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
