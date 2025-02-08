import 'package:flutter/material.dart';

import '../../../modules/user_dashboard/model/check_in_and_out_history_result.dart';
import '../../app_setting.dart';
import '../../helpers/app_date_formatter.dart';

class AttendantItemWidget extends StatelessWidget {
  const AttendantItemWidget({
    super.key,
    required this.item,
    required this.isLastItem,
    required this.onClick,
  });

  final CheckInAndOutHistoryData item;
  final bool isLastItem;
  final GestureTapCallback onClick;

  @override
  Widget build(BuildContext context) {
    double remainingWidth = MediaQuery.of(context).size.width - 122;
    String rawDateTime = '';
    if (item.checkStatus == null) {
      rawDateTime = '';
    } else if (item.checkStatus?.toLowerCase() == 'in') {
      rawDateTime = '${item.checkInDate}';
    } else if (item.checkStatus?.toLowerCase() == 'out') {
      rawDateTime = '${item.updatedDate}';
    }
    String formattedDateTime = AppDateFormatter.formatDateWithLocalTimeZone(
      pattern: AppDateFormatter.monthCommaDateYearDashTwelveHourTime,
      dateString: rawDateTime,
    );

    return GestureDetector(
      onTap: () {
        onClick.call();
      },
      child: Card(
        margin: EdgeInsets.only(
          top: AppStyle.horizontalPadding,
          left: AppStyle.horizontalPadding,
          right: AppStyle.horizontalPadding,
          bottom: isLastItem ? AppStyle.horizontalPadding : 0,
        ),
        color: AppColor.cardColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppStyle.borderRadius),
          ),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Row(
            children: [
              Image.asset(
                item.checkStatus?.toLowerCase() == 'in'
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
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
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
                          'Date: ${formattedDateTime.split('-')[0].trim()}',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: AppColor.textSecondaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      SizedBox(
                        width: (remainingWidth * 0.5) - 2,
                        child: Text(
                          'Time: ${formattedDateTime.split('-')[1].trim()}',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
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
        ),
      ),
    );
  }
}
