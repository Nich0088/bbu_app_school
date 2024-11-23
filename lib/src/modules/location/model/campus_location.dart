import 'package:json_annotation/json_annotation.dart';

part 'campus_location.g.dart';

@JsonSerializable()
class CampusLocation {
  CampusLocation({
    this.location,
  });

  @JsonKey(name: 'location')
  final List<CampusLocationData>? location;

  factory CampusLocation.fromJson(Map<String, dynamic> json) =>
      _$CampusLocationFromJson(json);

  Map<String, dynamic> toJson() => _$CampusLocationToJson(this);
}

@JsonSerializable()
class CampusLocationData {
  CampusLocationData({
    this.campus,
    this.latitude,
    this.longitude,
    this.addressPlace,
  });

  @JsonKey(name: 'campus')
  final String? campus;
  @JsonKey(name: 'latitude')
  final String? latitude;
  @JsonKey(name: 'longitude')
  final String? longitude;
  @JsonKey(name: 'address_place')
  final String? addressPlace;

  factory CampusLocationData.fromJson(Map<String, dynamic> json) =>
      _$CampusLocationDataFromJson(json);

  Map<String, dynamic> toJson() => _$CampusLocationDataToJson(this);
}
