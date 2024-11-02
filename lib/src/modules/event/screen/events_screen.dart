import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../constants/app_setting.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // Center vertically
            children: [
              // Display the Image
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 5, // Blur radius
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
                          child: Image.asset(
                            'assets/events1.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 12.0, top: 4),
                          child: Text(
                            'ការលើកកម្ពស់ការយល់ដឹងអំពីភាពជាអ្នកដឹកនាំ...',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black, // Text color
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 12.0, top: 2),
                          child: Text(
                            'ការលើកកម្ពស់ការយល់ដឹងអំពីភាពជាអ្នកដឹកនាំ...',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black, // Text color
                              fontSize: 14,
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
                        child: const Text(
                          "24.08.15",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 5, // Blur radius
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
                          child: Image.asset(
                            'assets/events1.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 12.0, top: 4),
                          child: Text(
                            'ការលើកកម្ពស់ការយល់ដឹងអំពីភាពជាអ្នកដឹកនាំ...',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black, // Text color
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 12.0, top: 2),
                          child: Text(
                            'ការលើកកម្ពស់ការយល់ដឹងអំពីភាពជាអ្នកដឹកនាំ...',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black, // Text color
                              fontSize: 14,
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
                        child: const Text(
                          "24.08.15",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 5, // Blur radius
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
                          child: Image.asset(
                            'assets/events1.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 12.0, top: 4),
                          child: Text(
                            'ការលើកកម្ពស់ការយល់ដឹងអំពីភាពជាអ្នកដឹកនាំ...',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black, // Text color
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 12.0, top: 2),
                          child: Text(
                            'ការលើកកម្ពស់ការយល់ដឹងអំពីភាពជាអ្នកដឹកនាំ...',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black, // Text color
                              fontSize: 14,
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
                        child: const Text(
                          "24.08.15",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // Display the Text
            ],
          ),
        ),
      ),
    );
  }
}
