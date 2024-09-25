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
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              AppLogo.events,
              fit: BoxFit.fill,
              // height: 150,git init
              // width: 110,
            ),
          )
          Container(
            color: Colors.black54, // Optional: semi-transparent background for better readability
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Overlay Text',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }
}
