// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_in_or_out_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckInOrOutResult _$CheckInOrOutResultFromJson(Map<String, dynamic> json) =>
    CheckInOrOutResult(
      code: json['code'] as String?,
      message: json['message'] as String?,
      messageKH: json['messageKH'],
      checkInOrOutData: json['data'] == null
          ? null
          : CheckInOrOutData.fromJson(json['data'] as Map<String, dynamic>),
      metadata: json['metadata'],
    );

Map<String, dynamic> _$CheckInOrOutResultToJson(CheckInOrOutResult instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'messageKH': instance.messageKH,
      'data': instance.checkInOrOutData,
      'metadata': instance.metadata,
    };

CheckInOrOutData _$CheckInOrOutDataFromJson(Map<String, dynamic> json) =>
    CheckInOrOutData(
      id: (json['id'] as num?)?.toInt(),
      studentId: json['studentId'] as String?,
      scheduleId: json['scheduleId'] as String?,
      subjectId: json['subjectId'] as String?,
      checkInDate: json['checkInDate'] as String?,
      checkOutDate: json['checkOutDate'],
      checkStatus: json['checkStatus'] as String?,
      status: json['status'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      createdDate: json['createdDate'] as String?,
      updatedDate: json['updatedDate'] as String?,
      latitude: json['latitude'],
      longitude: json['longitude'],
      parentId: (json['parentId'] as num?)?.toInt(),
      checkOut: json['checkOut'],
    );

Map<String, dynamic> _$CheckInOrOutDataToJson(CheckInOrOutData instance) =>
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
