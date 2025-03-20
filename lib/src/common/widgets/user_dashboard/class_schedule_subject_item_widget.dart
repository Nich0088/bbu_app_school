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
    required this.index
  });

  final ClassScheduleSubjectData item;
  final bool isNotFirstItem;
  final bool isLastItem;
  final int index;
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
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text( "$index. ${ item.subjectNameen}"
                     ,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10,),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Day : ${item.dayname} : Time : ${item.timeGeneral}",
                  style: TextStyle(color: Colors.indigo),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Teacher Name : ${item.teaName}",
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.start,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
