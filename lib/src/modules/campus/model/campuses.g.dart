// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campuses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Campuses _$CampusesFromJson(Map<String, dynamic> json) => Campuses(
      campuses: (json['campuses'] as List<dynamic>?)
          ?.map((e) => CampusesData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CampusesToJson(Campuses instance) => <String, dynamic>{
      'campuses': instance.campuses,
    };

CampusesData _$CampusesDataFromJson(Map<String, dynamic> json) => CampusesData(
      campus: json['campus'] as String?,
      tel: json['tel'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      imgPath: json['img_path'] as String?,
    );

Map<String, dynamic> _$CampusesDataToJson(CampusesData instance) =>
    <String, dynamic>{
      'campus': instance.campus,
      'tel': instance.tel,
      'email': instance.email,
      'address': instance.address,
      'img_path': instance.imgPath,
    };
