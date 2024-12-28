import 'package:flutter/material.dart';
import 'package:school_app/src/modules/dashboard/models/certificate_format_item.dart';

class CertificateFormatItemWidget extends StatelessWidget {
  const CertificateFormatItemWidget({
    super.key,
    required this.item,
    required this.onTap,
    required this.index,
  });

  final GestureTapCallback onTap;
  final CertificateFormatItem item;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap.call();
      },
      child: Container(
        margin: EdgeInsets.only(
          top: 12,
          right: 0,
          bottom: 12,
          left: index == 0 ? 0 : 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                // border: Border.all(
                //   color: AppColor.cardColor, // Border color
                //   width: 1, // Border width
                // ),
                borderRadius: BorderRadius.circular(3), // Rounded corners
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3), // Clip image corners
                child: Image.asset(
                  item.image,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.4),
              child: Text(
                item.title,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.white, fontSize: 9),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
