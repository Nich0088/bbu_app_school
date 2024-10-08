import 'package:flutter/material.dart';
import 'package:school_app/src/constants/app_setting.dart';
import 'package:school_app/src/modules/dashboard/models/home_grid_item.dart';

class HomeGridItemWidget extends StatelessWidget {
  const HomeGridItemWidget({
    super.key,
    required this.item,
    required this.onTap,
  });

  final HomeGridItem item;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [AppStyle.boxShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              item.image,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 4),
            Text(
              item.title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColor.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
