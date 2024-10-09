import 'package:flutter/material.dart';

import '../../../../constants/app_setting.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        debugPrint("Tab changed to: ${_tabController.index}");
      }
    });
  }

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
        backgroundColor: AppColor.primaryColor,
        // Customize AppBar color
        centerTitle: true,
        // Center the title
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.directions_car)),
            Tab(icon: Icon(Icons.directions_transit)),
            Tab(icon: Icon(Icons.directions_bike)),
          ],
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
