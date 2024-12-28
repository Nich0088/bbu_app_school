class LocationRes {
  LocationRes({
    required this.locationList,
  });

  List<LocationModel> locationList;

  factory LocationRes.fromJson(Map<String, dynamic> json) => LocationRes(
        locationList: List<LocationModel>.from(
            json["location"].map((x) => LocationModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "location": List<dynamic>.from(locationList.map((x) => x.toJson())),
      };
}

class LocationModel {
  LocationModel({
    required this.campus,
    this.latitude,
    this.longitude,
    this.addressPlace,
  });

  String campus;
  String? latitude;
  String? longitude;
  String? addressPlace;

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        campus: json["campus"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        addressPlace: json["address_place"],
      );

  Map<String, dynamic> toJson() => {
        "campus": campus,
        "latitude": latitude,
        "longitude": longitude,
        "address_place": addressPlace,
      };
}
