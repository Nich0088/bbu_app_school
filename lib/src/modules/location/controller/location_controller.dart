import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:school_app/src/modules/location/model/campus_location.dart';

import '../../../common/api_endpoint.dart';
import '../../../common/helpers/app_dialog_helper.dart';

class LocationController extends GetxController {
  RxSet<Marker> campusLocationMarkers = <Marker>{}.obs;
  var isShowLoading = false;
  AppDialogHelper? _appDialogHelper;

  void register(BuildContext context) {
    _appDialogHelper = AppDialogHelper(context: context);
  }

  @override
  void onInit() async {
    super.onInit();
    await _getCampusLocation().then(
      (campusLocation) async {
        List<CampusLocationData>? listOfCampusLocation =
            campusLocation?.location;
        if (listOfCampusLocation != null) {
          campusLocationMarkers.value =
              await _generateMarkers(listOfCampusLocation);
        }
      },
    );
  }

  Future<CampusLocation?> _getCampusLocation() async {
    String urlString =
        ApiEndpoint.unAuthorizeBastUrl + ApiEndpoint.viewLocation;
    debugPrint("$urlString");
    var url = Uri.parse(urlString);
    _setLoadingState(true);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );
    _setLoadingState(false);
    if (response.statusCode == 200) {
      return CampusLocation.fromJson(jsonDecode(response.body));
    } else {
      _appDialogHelper?.showErrorDialog(
        errorMessage: 'something when wrong',
        errorCode: '',
      );
    }
    return null;
  }

  void _setLoadingState(bool isLoading) {
    isShowLoading = isLoading;
    update();
  }

  Future<Set<Marker>> _generateMarkers(
      List<CampusLocationData> campusLocationList) async {
    Set<Marker> markers = {};
    for (var campusLocation in campusLocationList) {
      final markerIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(80, 80)),
        'assets/location/logo_map_maker.ico',
      );
      String? latitude = campusLocation.latitude;
      String? longitude = campusLocation.longitude;

      if (latitude != null && longitude != null) {
        markers.add(
          Marker(
            markerId: MarkerId('marker_${campusLocation.campus ?? ''}'),
            position: LatLng(
              double.parse(latitude),
              double.parse(longitude),
            ),
            icon: markerIcon,
            infoWindow: InfoWindow(
              title: campusLocation.campus,
            ),
          ),
        );
      }
    }

    return markers;
  }
}
