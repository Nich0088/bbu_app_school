import 'package:flutter/material.dart';
import 'package:school_app/src/common/app_setting.dart';
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
        decoration: const BoxDecoration(
          // color: AppColor.background,
          color: Colors.black26,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          // boxShadow: [AppStyle.boxShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              item.image,
              width: 35,
              height: 35,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 4),
            Text(
              item.title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColor.textPrimaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
