// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_of_birth_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceOfBirthResult _$PlaceOfBirthResultFromJson(Map<String, dynamic> json) =>
    PlaceOfBirthResult(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      placeOfBirthData: (json['data'] as List<dynamic>?)
          ?.map((e) => PlaceOfBirthData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlaceOfBirthResultToJson(PlaceOfBirthResult instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.placeOfBirthData,
    };

PlaceOfBirthData _$PlaceOfBirthDataFromJson(Map<String, dynamic> json) =>
    PlaceOfBirthData(
      nameObj: json['name_obj'] as String?,
    );

Map<String, dynamic> _$PlaceOfBirthDataToJson(PlaceOfBirthData instance) =>
    <String, dynamic>{
      'name_obj': instance.nameObj,
    };
