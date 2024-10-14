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
        width: double.infinity, // Set the width of the container
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [AppStyle.boxShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              item.image,
              width: 55,
              height: 55,
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
