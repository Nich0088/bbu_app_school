import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_app/src/constants/app_setting.dart';
import 'package:school_app/src/utils/widgets/custom_app_bar.dart';

import '../../../../modules/user_dashboard/controller/contact_controller.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<ContactScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ContactController _contactController = Get.put(ContactController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        debugPrint("Tab changed to: ${_tabController.index}");
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context,
        backgroundColor: AppColor.primaryColor,
        isDashboardAppBar: false,
        title: "Contact",
        isCenterTitle: true,
        bottom: TabBar(
          controller: _tabController,
          // labelColor: AppColor.textPrimaryColor,
          labelColor: Colors.white,
          indicatorColor: const Color(0xCCE25425),
          indicatorSize: TabBarIndicatorSize.tab,
          unselectedLabelColor: AppColor.textPrimaryColor.withOpacity(0.3),
          tabs: const [
            Tab(
              text: "Call Us",
            ),
            Tab(
              text: "Our Social",
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: TabBarView(
          controller: _tabController,
          children: [
            _callUsTab(),
            _ourSocialTab(),
          ],
        ),
      ),
    );
  }

  Widget _callUsTab() {
    return ListView.builder(
      itemCount: _contactController.contactItemList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ContactItemWidget(
          item: _contactController.contactItemList[index],
        );
      },
    );
  }

  Widget _ourSocialTab() {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              "Build Bright University Head Office",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 16),
            Text(
              "Phnom Penh  Campus, Corner Street 1003 & 1988(Building A and Corner Street 1003 & 1992 (Building B), Sangkat Phnom Penh Thmey, Khan Sensok, Phnom Penh",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 18, color: Colors.black.withOpacity(0.6)),
            ),
            SizedBox(height: 16),
            Text(
              "Follow Us On",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(250),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // Set a background color if needed
                        border: Border.all(
                          color: AppColor.textSecondaryColor
                              .withOpacity(0.4), // Border color
                        ),
                        borderRadius: BorderRadius.circular(250),
                        // Rounded corners for the border
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            // Shadow color
                            blurRadius: 6.0,
                            // Softness of the shadow
                            spreadRadius: 2.0,
                            // Size of the shadow
                            offset:
                                Offset(0, 4), // Position of the shadow (x, y)
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(250),
                        // Ensure the image also has rounded corners
                        child: Image.asset(
                          "assets/dashboard/facebook.webp",
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                )

                // Image.asset(
                //   "assets/dashboard/youtube.webp",
                //   width: 40,
                //   height: 40,
                //   fit: BoxFit.cover,
                // ),
                // Image.asset(
                //   "assets/dashboard/call1.png",
                //   width: 33,
                //   height: 33,
                //   fit: BoxFit.cover,
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ContactItemWidget extends StatelessWidget {
  final ContactItem item;

  const ContactItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(
            color: AppColor.textPrimaryColor, // Background color
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: AppColor.textSecondaryColor.withOpacity(0.1),
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 25,
                spreadRadius: -5,
                offset: Offset(
                  0,
                  20,
                ),
              ),
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.04),
                blurRadius: 10,
                spreadRadius: -5,
                offset: Offset(
                  0,
                  10,
                ),
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(250),
                child: Container(
                  width: 35,
                  height: 35,
                  child: Image.asset(
                    item.image,
                    width: 400,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 45, top: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          // color: AppColor.primaryColor,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                          // Make the text bold
                        ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6, right: 1),
                        child: Image.asset(
                          "assets/dashboard/call.png",
                          width: 13,
                          height: 13,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        item.phoneNumber,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.black,
                              fontSize: 18.0,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 20, bottom: 0),
              child: Image.asset(
                "assets/dashboard/right-arrow.png",
                width: 15,
                height: 15,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
