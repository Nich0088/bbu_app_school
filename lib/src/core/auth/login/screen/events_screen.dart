import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        toolbarHeight: 120,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () {
                  // Action for more options
                },
              ),
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 110),
                margin: const EdgeInsets.only(top: 24),
                child: const Text(
                  'Events',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold, // Set text to italic
                  ),
                )),
          ],
        ),
        backgroundColor: AppColor.primaryColor, // Customize AppBar color
        centerTitle: true, // Center the title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            // The image widget
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                image: DecorationImage(
                  image: AssetImage('assets/events1.png'), // Your image asset
                  fit: BoxFit.fill,
                ),
              ),
            ),
            // The text widget positioned over the image
            Positioned(
              bottom: 0, // Position from the bottom
              left: 0,
              // Position from the left
              child: Container(
                padding: EdgeInsets.all(8.0),
                width: 361,
                // Padding around the column
                decoration: BoxDecoration(
                  color: Colors.white, // Background color of the container
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight:
                        Radius.circular(16), // Rounded bottom-left corner
                  ), // Rounded corners
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'ការលើកកម្ពស់ការយល់ដឹងអំពីភាពជាអ្នកដឹកនាំ...',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                      child: Text(
                        'ការលើកកម្ពស់ការយល់ដឹងអំពីភាពជាអ្នកដឹកនាំ...',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// Positioned(
// right: 0, // Position from the right edge
// top: 20,  // Position from the top edge
// child: Container(
// padding: EdgeInsets.all(8.0), // Padding inside the container
// color: Colors.yellow,            // Background color of the container
// child: Text(
// '24,08,24',
// style: TextStyle(fontSize: 16, color: Colors.black),
// ),
// ),
// ),
