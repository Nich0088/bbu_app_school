// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campus_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampusLocation _$CampusLocationFromJson(Map<String, dynamic> json) =>
    CampusLocation(
      location: (json['location'] as List<dynamic>?)
          ?.map((e) => CampusLocationData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CampusLocationToJson(CampusLocation instance) =>
    <String, dynamic>{
      'location': instance.location,
    };

CampusLocationData _$CampusLocationDataFromJson(Map<String, dynamic> json) =>
    CampusLocationData(
      campus: json['campus'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      addressPlace: json['address_place'] as String?,
    );

Map<String, dynamic> _$CampusLocationDataToJson(CampusLocationData instance) =>
    <String, dynamic>{
      'campus': instance.campus,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address_place': instance.addressPlace,
    };
