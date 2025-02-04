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
      messageKH: json['messageKH'],
      checkInAndOutHistoryDataList: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              CheckInAndOutHistoryData.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['metadata'],
    );

Map<String, dynamic> _$CheckInAndOutHistoryResultToJson(
        CheckInAndOutHistoryResult instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'messageKH': instance.messageKH,
      'data': instance.checkInAndOutHistoryDataList,
      'metadata': instance.metadata,
    };

CheckInAndOutHistoryData _$CheckInAndOutHistoryDataFromJson(
        Map<String, dynamic> json) =>
    CheckInAndOutHistoryData(
      id: (json['id'] as num?)?.toInt(),
      studentId: json['studentId'] as String?,
      scheduleId: json['scheduleId'] as String?,
      subjectId: json['subjectId'] as String?,
      checkInDate: json['checkInDate'] as String?,
      checkOutDate: json['checkOutDate'],
      checkStatus: json['checkStatus'] as String?,
      status: json['status'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'],
      createdDate: json['createdDate'] as String?,
      updatedDate: json['updatedDate'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      parentId: (json['parentId'] as num?)?.toInt(),
      checkOut: json['checkOut'],
    );

Map<String, dynamic> _$CheckInAndOutHistoryDataToJson(
        CheckInAndOutHistoryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studentId': instance.studentId,
      'scheduleId': instance.scheduleId,
      'subjectId': instance.subjectId,
      'checkInDate': instance.checkInDate,
      'checkOutDate': instance.checkOutDate,
      'checkStatus': instance.checkStatus,
      'status': instance.status,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'createdDate': instance.createdDate,
      'updatedDate': instance.updatedDate,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'parentId': instance.parentId,
      'checkOut': instance.checkOut,
    };
