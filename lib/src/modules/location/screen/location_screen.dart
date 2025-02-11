import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../common/app_setting.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/loading_scaffold_widget.dart';
import '../controller/location_controller.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final LocationController _locationController = Get.put(LocationController());
  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(11.57204440, 104.88355400),
    zoom: 18,
  );
  late GoogleMapController _googleMapController;

  @override
  Widget build(BuildContext context) {
    _locationController.register(context);

    return GetBuilder<LocationController>(
      builder: (controller) => LoadingScaffoldWidget(
        isShowLoading: controller.isShowLoading,
        appBar: CustomAppBar(
          context,
          backgroundColor: AppColor.primaryColor,
          appBarType: AppBarType.generalType,
          title: "Location",
          isCenterTitle: true,
          onPressedBack: () {
            context.pop();
          },
        ),
        body: Obx(
          () => GoogleMap(
            mapType: MapType.satellite,
            onMapCreated: (GoogleMapController controller) {
              _googleMapController = controller;
            },
            zoomControlsEnabled: false,
            minMaxZoomPreference: const MinMaxZoomPreference(6, 18),
            initialCameraPosition: _initialCameraPosition,
            markers: controller.campusLocationMarkers.value,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(_initialCameraPosition));
          },
          child: const Icon(Icons.my_location),
        ),
      ),
    );
  }
}
