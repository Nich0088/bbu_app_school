// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_and_out_history_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckInAndOutHistoryResult _$CheckInAndOutHistoryResultFromJson(
        Map<String, dynamic> json) =>
    CheckInAndOutHistoryResult(
      code: json['code'] as String?,
      message: json['message'] as String?,
      checkInAndOutHistoryData: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              CheckInAndOutHistoryData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CheckInAndOutHistoryResultToJson(
        CheckInAndOutHistoryResult instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.checkInAndOutHistoryData,
    };

CheckInAndOutHistoryData _$CheckInAndOutHistoryDataFromJson(
        Map<String, dynamic> json) =>
    CheckInAndOutHistoryData(
      id: (json['id'] as num?)?.toInt(),
      studentId: (json['studentId'] as num?)?.toInt(),
      day: json['day'] as String?,
      date: json['date'] as String?,
      subject: json['subject'] as String?,
      status: json['status'] as String?,
      createAt: json['createAt'] as String?,
      createBy: json['createBy'] as String?,
      fromTime: json['fromTime'] as String?,
      toTime: json['toTime'],
    );

Map<String, dynamic> _$CheckInAndOutHistoryDataToJson(
        CheckInAndOutHistoryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studentId': instance.studentId,
      'day': instance.day,
      'date': instance.date,
      'subject': instance.subject,
      'status': instance.status,
      'createAt': instance.createAt,
      'createBy': instance.createBy,
      'fromTime': instance.fromTime,
      'toTime': instance.toTime,
    };
