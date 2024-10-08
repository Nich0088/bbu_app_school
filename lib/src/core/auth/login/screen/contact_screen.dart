import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_setting.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
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
                  'Connect',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold, // Set text to italic
                  ),
                )),
          ],
        ),
        backgroundColor: AppColor.primaryColor, // Customize AppBar color
        centerTitle: true, // Center the title
        bottom: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.directions_car)),
            Tab(icon: Icon(Icons.directions_transit)),
            Tab(icon: Icon(Icons.directions_bike)),
          ],
        ),

      ),
    );
  }
}
