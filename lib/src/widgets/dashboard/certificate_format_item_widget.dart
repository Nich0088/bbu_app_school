import 'package:flutter/material.dart';
import 'package:school_app/src/constants/app_setting.dart';
import 'package:school_app/src/modules/dashboard/models/certificate_format_item.dart';

class CertificateFormatItemWidget extends StatelessWidget {
  const CertificateFormatItemWidget({
    super.key,
    required this.item,
    required this.onTap,
  });

  final GestureTapCallback onTap;
  final CertificateFormatItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: const Color(
          0xFFC2DBFF,
        ),
        boxShadow: [
          AppStyle.boxShadow,
        ],
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            item.image,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              item.title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
