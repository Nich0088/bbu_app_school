import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:school_app/src/common/widgets/loading_scaffold_widget.dart';
import 'package:school_app/src/modules/campus/controller/campus_controller.dart';

import '../../../common/app_setting.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../utils/helpers/utility_function.dart';
import '../model/campuses.dart';

class CampusScreen extends StatelessWidget {
  const CampusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CampusController campusController = Get.put(CampusController());
    campusController.register(context);

    return GetBuilder<CampusController>(
      builder: (controller) => LoadingScaffoldWidget(
        isShowLoading: controller.isShowLoading,
        appBar: CustomAppBar(
          context,
          backgroundColor: AppColor.primaryColor,
          appBarType: AppBarType.generalType,
          title: "Campus",
          isCenterTitle: true,
          onPressedBack: () {
            context.pop();
          },
        ),
        body: Obx(
          () => campusController.campuses.value.campuses != null
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: campusController.campuses.value.campuses?.length,
                  itemBuilder: (context, index) {
                    CampusesData? campusesData =
                        campusController.campuses.value.campuses?[index];

                    if (campusesData == null) {
                      return const SizedBox();
                    }

                    return CampusItemWidget(
                      item: campusesData,
                      isLastItem:
                          (campusController.campuses.value.campuses?.length ??
                                      0) -
                                  1 ==
                              index,
                    );
                  },
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}

class CampusItemWidget extends StatelessWidget {
  const CampusItemWidget({
    super.key,
    required this.item,
    required this.isLastItem,
  });

  final CampusesData item;
  final bool isLastItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: isLastItem ? 20 : 0,
      ),
      color: AppColor.cardColor,
      elevation: 4,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 200,
              child: CachedNetworkImage(
                imageUrl: item.imgPath ?? '',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 18,
              right: 20,
              left: 20,
              bottom: 12,
            ),
            child: Text(
              item.campus ?? '',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: AppColor.primaryColor, fontSize: 24.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 4,
              right: 20,
              left: 20,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.mail_outline_rounded,
                  size: 20,
                  color: AppColor.primaryColor,
                ),
                const SizedBox(width: 10),
                Text(
                  item.email ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.black, fontSize: 18.0),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 2,
              right: 20,
              left: 20,
              bottom: 2,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 20,
                  color: AppColor.primaryColor,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    item.address ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.black, fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
          // GestureDetector(
          //   onTap: () {
          //     _showPhoneNumberBottomSheet(context, item.tel);
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.only(
          //       top: 0,
          //       right: 20,
          //       left: 20,
          //       bottom: 20,
          //     ),
          //     child: Row(
          //       children: [
          //         const Icon(
          //           Icons.phone,
          //           size: 20,
          //           color: AppColor.primaryColor,
          //         ),
          //         const SizedBox(width: 9),
          //         Expanded(
          //           child: Text(
          //             item.tel ?? '',
          //             maxLines: 2,
          //             style: Theme.of(context)
          //                 .textTheme
          //                 .titleLarge
          //                 ?.copyWith(color: Colors.black, fontSize: 18.0),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  void _showPhoneNumberBottomSheet(BuildContext context, String? phoneNumber) {
    if (phoneNumber == null) return;

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                ...phoneNumber.split(',').map(
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
}
