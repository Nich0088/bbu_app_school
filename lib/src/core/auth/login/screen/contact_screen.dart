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
          onPressed: () {
            _showBottomSheet(
                context, _contactController.contactItemList[index]);
          },
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
                          "assets/dashboard/communication .png",
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
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
                          "assets/dashboard/youtube.png",
                          width: 10,
                          height: 10,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
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
                          "assets/dashboard/call1.png",
                          width: 0,
                          height: 0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, ContactItem item) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: 60,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: Color(0x617C7C7C),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                const SizedBox(height: 4),
                ...item.phoneNumberList.map(
                  (phoneNumber) => Row(
                    // crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 4, right: 44),
                        child: Image.asset(
                          "assets/dashboard/call.png",
                          width: 22,
                          height: 22,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        phoneNumber,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColor.primaryColor,
                              fontSize: 32,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ContactItemWidget extends StatelessWidget {
  final ContactItem item;
  final GestureTapCallback onPressed;

  const ContactItemWidget(
      {super.key, required this.item, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Padding(
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
              boxShadow: const [
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
                child: ClipOval(
                  child: Image.asset(
                    item.image,
                    width: 20,
                    height: 20,
                    fit: BoxFit.cover,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 26, right: 1),
                          child: Image.asset(
                            "assets/dashboard/call.png",
                            width: 13,
                            height: 13,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            item.phoneNumberList.join(", "),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                    ),
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
      ),
    );
  }
}
