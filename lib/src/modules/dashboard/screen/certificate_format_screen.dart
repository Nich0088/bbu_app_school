import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/src/modules/dashboard/models/certificate_format_item.dart';

import '../../../common/app_setting.dart';
import '../../../common/widgets/custom_app_bar.dart';

class CertificateFormatScreen extends StatelessWidget {
  const CertificateFormatScreen({super.key, this.certificateFormatItem});

  final CertificateFormatItem? certificateFormatItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context,
        backgroundColor: AppColor.primaryColor,
        appBarType: AppBarType.generalType,
        title: certificateFormatItem?.title ?? '',
        isCenterTitle: true,
        onPressedBack: () {
          context.pop();
        },
      ),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: certificateFormatItem?.imageUrl ?? '',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
