import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../main.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/app_setting.dart';
import '../controller/event_controller.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final EventController _eventsController = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context,
        backgroundColor: AppColor.primaryColor,
        isDashboardAppBar: false,
        title: "Events",
        isCenterTitle: true,
        onPressedBack: () {
          context.pop();
        },
      ),
      body: Obx(
        () {
          if (_eventsController.eventResult.value.eventData == null) {
            return const SizedBox();
          } else {
            return ListView.builder(
              itemCount: _eventsController.eventResult.value.eventData?.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  context.push(
                    AppScreen.eventDetailScreen.path,
                    extra:
                        _eventsController.eventResult.value.eventData?[index],
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(16.0),
                  width: double.infinity,
                  height: 230,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3), // Offset in x, y
                      ),
                    ],
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: _eventsController.eventResult.value
                                      .eventData?[index].image ??
                                  "",
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: 168,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 11.0, top: 4),
                            child: Text(
                              _eventsController.eventResult.value
                                      .eventData?[index].title ??
                                  "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                color: Colors.black, // Text color
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0, top: 2),
                            child: Text(
                              _eventsController.eventResult.value
                                      .eventData?[index].description ??
                                  "",
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black, // Text color
                                fontSize: 14,
                                fontWeight: FontWeight.w100,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 16,
                        right: -10,
                        child: Container(
                          padding: const EdgeInsets.only(left: 4, right: 4),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Text(
                            _eventsController
                                    .eventResult.value.eventData?[index].date ??
                                "",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
