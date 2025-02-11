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
  var listOfCampusLatLng = <LatLng>[].obs;
  var isShowLoading = false;
  AppDialogHelper? _appDialogHelper;

  void register(BuildContext context) {
    _appDialogHelper = AppDialogHelper(context: context);
  }

  Future<CampusLocation?> getCampusLocation() async {
    String urlString =
        ApiEndpoint.unAuthorizeBastUrl + ApiEndpoint.viewLocation;
    debugPrint(urlString);
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

  Future<void> generateMarkers(
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
        LatLng latLng = LatLng(
          double.parse(latitude),
          double.parse(longitude),
        );
        listOfCampusLatLng.add(latLng);
        markers.add(
          Marker(
            markerId: MarkerId('marker_${campusLocation.campus ?? ''}'),
            position: latLng,
            icon: markerIcon,
            infoWindow: InfoWindow(
              title: campusLocation.campus,
            ),
          ),
        );
      }
    }

    campusLocationMarkers.value = markers;
  }

  LatLngBounds? getBoundToFitMarkers() {
    if (listOfCampusLatLng.isEmpty) return null;

    return _getBoundsFromMarkers(listOfCampusLatLng);
  }

  LatLngBounds _getBoundsFromMarkers(List<LatLng> listOfLatLng) {
    double southWestLat = listOfLatLng.first.latitude;
    double southWestLng = listOfLatLng.first.longitude;
    double northEastLat = listOfLatLng.first.latitude;
    double northEastLng = listOfLatLng.first.longitude;

    for (LatLng marker in listOfLatLng) {
      if (marker.latitude < southWestLat) southWestLat = marker.latitude;
      if (marker.longitude < southWestLng) southWestLng = marker.longitude;
      if (marker.latitude > northEastLat) northEastLat = marker.latitude;
      if (marker.longitude > northEastLng) northEastLng = marker.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(southWestLat, southWestLng),
      northeast: LatLng(northEastLat, northEastLng),
    );
  }
}
