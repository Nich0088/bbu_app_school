import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_setting.dart';
import '../../../modules/user_dashboard/model/schedule_item.dart';

class ScheduleItemWidget extends StatelessWidget {
  final bool isLastItem;
  final ScheduleItem item;
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
                child: CachedNetworkImage(
                  width: 60,
                  height: 60,
                  imageUrl: item.image,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 176) * 0.6,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.black),
                    ),
                    Text(
                      item.subTitle,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const SizedBox(width: 20),
              SizedBox(
                width: (MediaQuery.of(context).size.width - 176) * 0.4,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      item.date,
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black),
                    ),
                    Text(
                      "Room: ${item.roomName}",
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
