// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_schedule_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassScheduleResult _$ClassScheduleResultFromJson(Map<String, dynamic> json) =>
    ClassScheduleResult(
      code: json['code'] as String?,
      message: json['message'] as String?,
      messageKH: json['messageKH'],
      classScheduleDataList: (json['data'] as List<dynamic>?)
          ?.map((e) => ClassScheduleData.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['metadata'],
    );

Map<String, dynamic> _$ClassScheduleResultToJson(
        ClassScheduleResult instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'messageKH': instance.messageKH,
      'data': instance.classScheduleDataList,
      'metadata': instance.metadata,
    };

ClassScheduleData _$ClassScheduleDataFromJson(Map<String, dynamic> json) =>
    ClassScheduleData(
      id: (json['id'] as num?)?.toInt(),
      studentId: json['studentId'] as String?,
      scheduleId: json['scheduleId'] as String?,
      branchId: json['branchId'] as String?,
      scheduleShortName: json['scheduleShortName'] as String?,
      status: json['status'] as String?,
      facultyShortName: json['facultyShortName'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      roomId: json['roomId'] as String?,
      roomName: json['roomName'] as String?,
    );

Map<String, dynamic> _$ClassScheduleDataToJson(ClassScheduleData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studentId': instance.studentId,
      'scheduleId': instance.scheduleId,
      'branchId': instance.branchId,
      'scheduleShortName': instance.scheduleShortName,
      'status': instance.status,
      'facultyShortName': instance.facultyShortName,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'roomId': instance.roomId,
      'roomName': instance.roomName,
    };
