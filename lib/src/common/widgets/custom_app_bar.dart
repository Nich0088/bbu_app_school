import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_app/src/common/app_setting.dart';

PreferredSizeWidget CustomAppBar(
  BuildContext context, {
  double elevation = 0.0,
  bool isDashboardAppBar = false,
  bool isDarkStatusBar = false,
  bool isCenterTitle = false,
  Color iconColor = Colors.white,
  String title = '',
  String username = '',
  String imageUrl = '',
  Color? backgroundColor,
  GestureTapCallback? onPressedBack,
  GestureTapCallback? onViewProfile,
  GestureTapCallback? onNotificationPressed,
  GestureTapCallback? onLanguagePressed,
  Color? colorTitle,
  bool automaticallyImplyLeading = true,
  PreferredSizeWidget? bottom,
}) {
  return AppBar(
    backgroundColor: backgroundColor,
    elevation: elevation,
    automaticallyImplyLeading: automaticallyImplyLeading,
    leading: (() {
      if (isDashboardAppBar == false) {
        return IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: iconColor,
          ),
          onPressed: () {
            onPressedBack?.call();
          },
        );
      }
    }()),
    title: (() {
      if (isDashboardAppBar) {
        return GestureDetector(
          onTap: () {
            onViewProfile?.call();
          },
          child: Row(
            children: [
              const SizedBox(
                width: 3,
              ),
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: AppStyle.horizontalPadding,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    "View Profile >",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        );
      } else if (title.isNotEmpty) {
        return Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: colorTitle),
        );
      }
    }()),
    centerTitle: isCenterTitle,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarBrightness:
          isDarkStatusBar == true ? Brightness.light : Brightness.dark,
    ),
    actions: [
      if (isDashboardAppBar == true)
        IconButton(
          icon: Icon(
            Icons.notifications_none_outlined,
            color: iconColor,
          ),
          onPressed: () {
            onNotificationPressed?.call();
          },
        ),
      if (isDashboardAppBar == true)
        IconButton(
          icon: Icon(
            Icons.language,
            color: iconColor,
          ),
          onPressed: () {
            onLanguagePressed?.call();
          },
        ),
      const SizedBox(
        width: 6,
      ),
    ],
    bottom: bottom,
  );
}
