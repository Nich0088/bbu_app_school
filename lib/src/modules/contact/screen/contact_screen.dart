import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/src/common/app_setting.dart';
import 'package:school_app/src/modules/contact/controller/contact_controller.dart';
import 'package:school_app/src/modules/contact/model/contact.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../utils/helpers/utility_function.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ContactController _contactController = Get.put(ContactController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

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
    _contactController.register(context);
    return Scaffold(
      appBar: CustomAppBar(
        context,
        backgroundColor: AppColor.primaryColor,
        appBarType: AppBarType.generalType,
        title: context.tr('contact'),
        onPressedBack: () {
          context.pop();
        },
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
    return Obx(() {
      if (_contactController.contactList.value.data == null) {
        return const SizedBox();
      } else {
        return ListView.builder(
          itemCount: _contactController.contactList.value.data?.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            ContactData? item =
                _contactController.contactList.value.data?[index];

            if (item == null) return const SizedBox();

            return ContactItemWidget(
              item: item,
              onPressed: () {
                _showBottomSheet(
                  context,
                  item,
                );
              },
            );
          },
        );
      }
    });
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
            const SizedBox(height: 16),
            Text(
              "Phnom Penh  Campus, Corner Street 1003 & 1988(Building A and Corner Street 1003 & 1992 (Building B), Sangkat Phnom Penh Thmey, Khan Sensok, Phnom Penh",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 18, color: Colors.black.withOpacity(0.6)),
            ),
            const SizedBox(height: 16),
            Text(
              "Follow Us On",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    openUrl("https://www.facebook.com/bbu.edu.kh/");
                  },
                  child: Padding(
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
                              offset: const Offset(
                                  0, 4), // Position of the shadow (x, y)
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(250),
                          // Ensure the image also has rounded corners
                          child: Image.asset(
                            "assets/dashboard/communication.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    openUrl(
                        "https://m.youtube.com/@BuildBrightUniversityOfficial");
                  },
                  child: Padding(
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
                              offset: const Offset(
                                  0, 4), // Position of the shadow (x, y)
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(250),
                          // Ensure the image also has rounded corners
                          child: Image.asset(
                            "assets/dashboard/youtube.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _showModalBottomSheet(context);
                  },
                  child: Padding(
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
                              offset: const Offset(
                                  0, 4), // Position of the shadow (x, y)
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(250),
                          // Ensure the image also has rounded corners
                          child: Image.asset(
                            "assets/dashboard/call1.png",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
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

  void _showModalBottomSheet(BuildContext context) {
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
                Row(
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
                    GestureDetector(
                      onTap: () {
                        _dialPhoneNumberOnsocial("023 987 700");
                      },
                      child: Text(
                        "023 987 700",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColor.primaryColor,
                              fontSize: 32,
                            ),
                      ),
                    ),
                  ],
                ),
                Row(
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
                    GestureDetector(
                      onTap: () {
                        _dialPhoneNumberOnsocial("012 682 777");
                      },
                      child: Text(
                        "012 682 777",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColor.primaryColor,
                              fontSize: 32,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showBottomSheet(BuildContext context, ContactData item) {
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
                ...?item.phone?.split(',').map(
                      (phoneNumber) => Row(
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
                          GestureDetector(
                            onTap: () {
                              dialPhoneNumber(phoneNumber);
                            },
                            child: Text(
                              phoneNumber.trim(),
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppColor.primaryColor,
                                    fontSize: 32,
                                  ),
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

  void _dialPhoneNumberOnsocial(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }
}

class ContactItemWidget extends StatelessWidget {
  final ContactData item;
  final GestureTapCallback onPressed;

  const ContactItemWidget({
    super.key,
    required this.item,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        clipBehavior: Clip.antiAlias,
        elevation: 8.0,
        margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6.0),
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: ListTile(
              minVerticalPadding: height * 0.02,
              leading: Container(
                height: height * 0.06,
                padding: const EdgeInsets.only(right: 12.0),
                decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide(width: 1.0, color: Colors.white24))),
                child: CircleAvatar(
                  radius: height * 0.02,
                  backgroundColor: Colors.indigo,
                  backgroundImage: const AssetImage("assets/app_logo.png"),
                ),
              ),
              title: Text(
                item.campus ?? "",
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: height * 0.023,
                    ),
              ),
              subtitle: Row(
                children: <Widget>[
                  Icon(
                    Icons.call,
                    color: Colors.green,
                    size: height * 0.023,
                  ),
                  Expanded(
                    child: Text(item.phone ?? '',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black, fontSize: height * 0.02)),
                  )
                ],
              ),
              trailing: Icon(Icons.keyboard_arrow_right,
                  color: Colors.black, size: height * 0.04)),
        ),
      ),
      // child: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Container(
      //     width: double.infinity,
      //     height: 70,
      //     decoration: BoxDecoration(
      //       color: AppColor.textPrimaryColor, // Background color
      //       borderRadius: BorderRadius.circular(16.0),
      //       border: Border.all(
      //         color: AppColor.textSecondaryColor.withOpacity(0.1),
      //       ),
      //       boxShadow: const [
      //         BoxShadow(
      //           color: Color.fromRGBO(0, 0, 0, 0.1),
      //           blurRadius: 25,
      //           spreadRadius: -5,
      //           offset: Offset(
      //             0,
      //             20,
      //           ),
      //         ),
      //         BoxShadow(
      //           color: Color.fromRGBO(0, 0, 0, 0.04),
      //           blurRadius: 10,
      //           spreadRadius: -5,
      //           offset: Offset(
      //             0,
      //             10,
      //           ),
      //         ),
      //       ],
      //     ),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Padding(
      //           padding: const EdgeInsets.only(left: 12, right: 0),
      //           child: CircleAvatar(
      //             radius: height * 0.02,
      //             backgroundColor: Colors.indigo,
      //             backgroundImage:
      //                 const AssetImage("assets/dashboard/app_logo.png"),
      //           ),
      //           // child: ClipOval(
      //           //   child: Image.asset(
      //           //     'assets/dashboard/app_logo.png',
      //           //     width: 30,
      //           //     height: 30,
      //           //     fit: BoxFit.cover,
      //           //   ),
      //           // ),
      //         ),
      //         const SizedBox(height: 4),
      //         Padding(
      //           padding: const EdgeInsets.only(left: 0, right: 40, top: 8),
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             children: [
      //               Text(
      //                 item.campus ?? "",
      //                 textAlign: TextAlign.start,
      //                 style: Theme.of(context).textTheme.bodySmall?.copyWith(
      //                       color: Colors.black,
      //                       fontWeight: FontWeight.bold,
      //                       fontSize: height*0.023,
      //                     ),
      //               ),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.start,
      //                 children: [
      //                   Padding(
      //                     padding: const EdgeInsets.only(left: 16, right: 1),
      //                     child: Image.asset(
      //                       "assets/dashboard/call.png",
      //                       width: 13,
      //                       height: 13,
      //                       fit: BoxFit.cover,
      //                     ),
      //                   ),
      //                   SizedBox(
      //                     width: MediaQuery.of(context).size.width - 186,
      //                     child: Text(
      //                       item.phone ?? '',
      //                       textAlign: TextAlign.center,
      //                       overflow: TextOverflow.ellipsis,
      //                       style:
      //                           Theme.of(context).textTheme.bodySmall?.copyWith(
      //                                 color: Colors.black,
      //                                 fontSize: 18.0,
      //                               ),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.only(left: 0, right: 20, bottom: 0),
      //           child: Image.asset(
      //             "assets/dashboard/right-arrow.png",
      //             width: 15,
      //             height: 15,
      //             fit: BoxFit.cover,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
