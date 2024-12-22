import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/src/modules/event/models/event_new_data.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/app_setting.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key, this.eventData});

  final EventData? eventData;

  @override
  Widget build(BuildContext context) {
    String? displayLongDescription = eventData?.longDescription
        ?.replaceAll('src="/ckfinder', 'src="https://bbu.edu.kh/ckfinder')
        .replaceAll('style="width:100%"', '');
    debugPrint(displayLongDescription);

    return Scaffold(
      appBar: CustomAppBar(
        context,
        backgroundColor: AppColor.primaryColor,
        isDashboardAppBar: false,
        title: "Detail news & Event",
        isCenterTitle: true,
        onPressedBack: () {
          context.pop();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: eventData?.image ?? '',
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                left: 8,
                right: 8,
              ),
              child: Text(
                eventData?.title ?? '',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.black),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Text(
                eventData?.date ?? '',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                    ),
              ),
            ),
            if (displayLongDescription != null)
              Html(data: displayLongDescription)
          ],
        ),
      ),
    );
  }
}
