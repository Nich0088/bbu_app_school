import 'package:flutter/material.dart';
import 'package:school_app/src/common/app_setting.dart';
import 'package:school_app/src/modules/user_dashboard/model/study_item.dart';

class StudyItemWidget extends StatelessWidget {
  final StudyItem item;
  final bool isLastItem;

  const StudyItemWidget(
      {super.key, required this.item, required this.isLastItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppStyle.horizontalPadding,
        left: AppStyle.horizontalPadding,
        right: AppStyle.horizontalPadding,
        bottom: isLastItem == true ? AppStyle.horizontalPadding : 0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.label,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: AppColor.textSecondaryColor),
          ),
          const SizedBox(height: 4),
          Container(
            decoration: const BoxDecoration(
              // color: Color(0x1AD9D9D9),
              color: AppColor.cardColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  offset: Offset(0, 4),
                  color: Color(0x40000000),
                ),
              ],
            ),
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Text(
              item.title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
