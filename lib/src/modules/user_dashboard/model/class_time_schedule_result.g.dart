// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_time_schedule_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassTimeScheduleResult _$ClassTimeScheduleResultFromJson(
        Map<String, dynamic> json) =>
    ClassTimeScheduleResult(
      message: json['message'] as String?,
      classTimeScheduleDataList: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => ClassTimeScheduleData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ClassTimeScheduleResultToJson(
        ClassTimeScheduleResult instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.classTimeScheduleDataList,
    };

ClassTimeScheduleData _$ClassTimeScheduleDataFromJson(
        Map<String, dynamic> json) =>
    ClassTimeScheduleData(
      scheduleDetailID: (json['scheduleDetailID'] as num?)?.toInt(),
      scheduleID: (json['scheduleID'] as num?)?.toInt(),
      promotionID: (json['promotionID'] as num?)?.toInt(),
      promotion: (json['promotion'] as num?)?.toInt(),
      stage: (json['stage'] as num?)?.toInt(),
      term: (json['term'] as num?)?.toInt(),
      teaID: (json['teaID'] as num?)?.toInt(),
      subjID: (json['subjID'] as num?)?.toInt(),
      roomID: (json['roomID'] as num?)?.toInt(),
      labID: (json['labID'] as num?)?.toInt(),
      dayTimeID: (json['dayTimeID'] as num?)?.toInt(),
      joinScheduleDetailID: (json['joinScheduleDetailID'] as num?)?.toInt(),
      fieldID: (json['fieldID'] as num?)?.toInt(),
      campusFacultyID: (json['campusFacultyID'] as num?)?.toInt(),
      scheduleStatus: (json['scheduleStatus'] as num?)?.toInt(),
      dayId: (json['dayid'] as num?)?.toInt(),
      timeId: (json['timeId'] as num?)?.toInt(),
      timeOrders: (json['timeOrders'] as num?)?.toInt(),
      teaName: json['teaName'] as String?,
      sex: json['sex'] as String?,
      phone: json['phone'] as String?,
      goupNote: json['goupNote'] as String?,
      facultyShortName: json['facultyShortName'] as String?,
      roomLab: json['roomLab'] as String?,
      typeRoomLab: json['typeRoomLab'] as String?,
      dayName: json['dayname'] as String?,
      timeGeneral: json['timeGeneral'] as String?,
      shift: json['shift'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      subjectCode: json['subject_code'] as String?,
      subjectNameEn: json['subject_nameen'] as String?,
      subjectNameKh: json['subject_namekh'] as String?,
    );

Map<String, dynamic> _$ClassTimeScheduleDataToJson(
        ClassTimeScheduleData instance) =>
    <String, dynamic>{
      'scheduleDetailID': instance.scheduleDetailID,
      'scheduleID': instance.scheduleID,
      'promotionID': instance.promotionID,
      'promotion': instance.promotion,
      'stage': instance.stage,
      'term': instance.term,
      'teaID': instance.teaID,
      'subjID': instance.subjID,
      'roomID': instance.roomID,
      'labID': instance.labID,
      'dayTimeID': instance.dayTimeID,
      'joinScheduleDetailID': instance.joinScheduleDetailID,
      'fieldID': instance.fieldID,
      'campusFacultyID': instance.campusFacultyID,
      'scheduleStatus': instance.scheduleStatus,
      'dayid': instance.dayId,
      'timeId': instance.timeId,
      'timeOrders': instance.timeOrders,
      'teaName': instance.teaName,
      'sex': instance.sex,
      'phone': instance.phone,
      'goupNote': instance.goupNote,
      'facultyShortName': instance.facultyShortName,
      'roomLab': instance.roomLab,
      'typeRoomLab': instance.typeRoomLab,
      'dayname': instance.dayName,
      'timeGeneral': instance.timeGeneral,
      'shift': instance.shift,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'subject_code': instance.subjectCode,
      'subject_nameen': instance.subjectNameEn,
      'subject_namekh': instance.subjectNameKh,
    };
