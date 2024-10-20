import 'package:flutter/material.dart';

import '../../../../common/widgets/custom_app_bar.dart';
import '../../../../constants/app_setting.dart';

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
                      offset: Offset(0, 3), // Offset in x, y
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
                          child: Image.asset(
                            'assets/events1.png',
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 4),
                          child: Text(
                            'ការលើកកម្ពស់ការយល់ដឹងអំពីភាពជាអ្នកដឹកនាំ...',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black, // Text color
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 2),
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
                      child: Container(
                        padding: EdgeInsets.only(left: 4, right: 4),
                        child: Text(
                          "24.08.15",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                      ),
                      top: 16,
                      right: -10,
                    )
                  ],
                ),
              ),
              SizedBox(height: 16),
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
                      offset: Offset(0, 3), // Offset in x, y
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
                          child: Image.asset(
                            'assets/events1.png',
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 4),
                          child: Text(
                            'ការលើកកម្ពស់ការយល់ដឹងអំពីភាពជាអ្នកដឹកនាំ...',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black, // Text color
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 2),
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
                      child: Container(
                        padding: EdgeInsets.only(left: 4, right: 4),
                        child: Text(
                          "24.08.15",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                      ),
                      top: 16,
                      right: -10,
                    )
                  ],
                ),
              ),
              SizedBox(height: 16),
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
                      offset: Offset(0, 3), // Offset in x, y
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
                          child: Image.asset(
                            'assets/events1.png',
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 4),
                          child: Text(
                            'ការលើកកម្ពស់ការយល់ដឹងអំពីភាពជាអ្នកដឹកនាំ...',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black, // Text color
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 2),
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
                      child: Container(
                        padding: EdgeInsets.only(left: 4, right: 4),
                        child: Text(
                          "24.08.15",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                      ),
                      top: 16,
                      right: -10,
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
