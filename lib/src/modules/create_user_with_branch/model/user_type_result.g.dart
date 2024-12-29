// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_type_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserTypeResult _$UserTypeResultFromJson(Map<String, dynamic> json) =>
    UserTypeResult(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      userTypeData: (json['data'] as List<dynamic>?)
          ?.map((e) => UserTypeData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserTypeResultToJson(UserTypeResult instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.userTypeData,
    };

UserTypeData _$UserTypeDataFromJson(Map<String, dynamic> json) => UserTypeData(
      id: (json['id'] as num?)?.toInt(),
      usertypeName: json['usertype_name'] as String?,
      usertypeStatus: json['usertype_status'] as bool?,
    );

Map<String, dynamic> _$UserTypeDataToJson(UserTypeData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'usertype_name': instance.usertypeName,
      'usertype_status': instance.usertypeStatus,
    };
