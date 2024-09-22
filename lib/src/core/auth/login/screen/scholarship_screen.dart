import 'package:flutter/material.dart';
import 'package:school_app/src/constants/app_setting.dart';

class ScholarshipScreen extends StatelessWidget {
  const ScholarshipScreen({super.key});

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
              margin: EdgeInsets.only(top: 15),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_new),
                onPressed: () {
                  // Action for more options
                },
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 80),
                margin: EdgeInsets.only(top: 24),
                child: Text(
                  'Scholarship',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold, // Set text to italic
                  ),
                )),
          ],
        ),
        backgroundColor: AppColor.primaryColor,// Customize AppBar color
        centerTitle: true, // Center the title
      ),
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.asset(
            AppLogo.scholarship,
            fit: BoxFit.fill,
            // height: 150,
            // width: 110,
          ), // Load i
        ),
      ),
    );
  }
}
