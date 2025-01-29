import 'package:flutter/material.dart';
import 'package:school_app/src/common/helpers/app_date_formatter.dart';
import 'package:school_app/src/modules/user_dashboard/model/class_schedule_result.dart';

import '../../app_setting.dart';

class ScheduleItemWidget extends StatelessWidget {
  final bool isLastItem;
  final ClassScheduleData item;
  final GestureTapCallback onClick;

  const ScheduleItemWidget({
    super.key,
    required this.isLastItem,
    required this.item,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onClick.call();
      },
      child: Container(
        margin: EdgeInsets.only(
          top: AppStyle.horizontalPadding,
          left: AppStyle.horizontalPadding,
          right: AppStyle.horizontalPadding,
          bottom: isLastItem ? AppStyle.horizontalPadding : 0,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppStyle.horizontalPadding,
          vertical: 16,
        ),
        decoration: const BoxDecoration(
          color: AppColor.cardColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Color(0x40000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: SizedBox(
          height: 60,
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
                    item.facultyShortName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 176) * 0.6,
                child: Text(
                  item.scheduleShortName ?? '',
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
                width: (MediaQuery.of(context).size.width - 176) * 0.4,
                child: Text(
                  AppDateFormatter.formatDate(
                    pattern: AppDateFormatter.monthCommaDateYear,
                    dateString: item.startDate?.split('T')[0],
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
      ),
    );
  }
}
