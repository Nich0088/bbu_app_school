// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:school_app/src/common/widgets/loading_scaffold_widget.dart';
// import 'package:school_app/src/common/app_setting.dart';
// import 'package:school_app/src/modules/location/controller/location_controller.dart';
//
// import '../../../common/widgets/custom_app_bar.dart';
//
// class LocationScreen extends StatefulWidget {
//   const LocationScreen({super.key});
//
//   @override
//   State<LocationScreen> createState() => _LocationScreenState();
// }
//
// class _LocationScreenState extends State<LocationScreen> {
//   final LocationController _locationController = Get.put(LocationController());
//   final CameraPosition _initialCameraPosition = const CameraPosition(
//     target: LatLng(11.57204440, 104.88355400),
//     zoom: 18,
//   );
//   late GoogleMapController _googleMapController;
//
//   @override
//   Widget build(BuildContext context) {
//     _locationController.register(context);
//
//     return GetBuilder<LocationController>(
//       builder: (controller) => LoadingScaffoldWidget(
//         isShowLoading: controller.isShowLoading,
//         appBar: CustomAppBar(
//           context,
//           backgroundColor: AppColor.primaryColor,
//           isDashboardAppBar: false,
//           title: "Location",
//           isCenterTitle: true,
//           onPressedBack: () {
//             context.pop();
//           },
//         ),
//         body: Obx(
//           () => GoogleMap(
//             mapType: MapType.satellite,
//             onMapCreated: (GoogleMapController controller) {
//               _googleMapController = controller;
//             },
//             zoomControlsEnabled: false,
//             minMaxZoomPreference: const MinMaxZoomPreference(7, 18),
//             initialCameraPosition: _initialCameraPosition,
//             markers: controller.campusLocationMarkers.value,
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             _googleMapController.animateCamera(
//                 CameraUpdate.newCameraPosition(_initialCameraPosition));
//           },
//           child: const Icon(Icons.my_location),
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:school_app/src/modules/location/screen/location.data.dart';
import 'package:school_app/src/modules/location/screen/location_res.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationScreen> {
  late BitmapDescriptor pinLocationIcon;
  bool loading = false;
  List<LocationModel> list = [];
  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    // final googleOffices = await locations.getGoogleOffices();
    LocationData data = LocationData();
    final result = await data.getLocationUsList();

    if (result.locationList.isNotEmpty) {
      setState(() {
        // _markers.add();

        list = result.locationList;
        for (final office in list) {
          final marker = Marker(
            markerId: MarkerId(office.campus),
            position: LatLng(double.parse(office.latitude!),
                double.parse(office.longitude!)),
            infoWindow: InfoWindow(
              title: office.campus.toString(),
              snippet: office.addressPlace,
            ),
            icon: pinLocationIcon,
          );
          _markers[office.campus] = marker;
        }
      });
    }
  }

  @override
  // ignore: must_call_super
  void initState() {
    //_onMapCreated();

    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(12.0, 12.0)),
            'assets/dashboard/logo_map_maker.ico')
        .then((onValue) {
      pinLocationIcon = onValue;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;
    var fontsize = height * 0.03;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.066,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: fontsize,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'location'.tr().toString(),
          style: TextStyle(fontSize: fontsize),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo[900],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(11.55418728, 104.93379951),
          zoom: 10,
          bearing: 30,
        ),
        markers: _markers.values.toSet(),
        // onTap: openMapsSheet(context,11.55418728,104.93379951),
      ),
    );
  }
}
