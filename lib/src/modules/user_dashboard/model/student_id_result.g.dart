// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_id_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentIdResult _$StudentIdResultFromJson(Map<String, dynamic> json) =>
    StudentIdResult(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$StudentIdResultToJson(StudentIdResult instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
