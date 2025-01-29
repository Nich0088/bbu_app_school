// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_schedule_subject_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassScheduleSubjectResult _$ClassScheduleSubjectResultFromJson(
        Map<String, dynamic> json) =>
    ClassScheduleSubjectResult(
      code: json['code'] as String?,
      message: json['message'] as String?,
      messageKH: json['messageKH'],
      classScheduleSubjectData: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              ClassScheduleSubjectData.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: json['metadata'],
    );

Map<String, dynamic> _$ClassScheduleSubjectResultToJson(
        ClassScheduleSubjectResult instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'messageKH': instance.messageKH,
      'data': instance.classScheduleSubjectData,
      'metadata': instance.metadata,
    };

ClassScheduleSubjectData _$ClassScheduleSubjectDataFromJson(
        Map<String, dynamic> json) =>
    ClassScheduleSubjectData(
      timeOrders: (json['timeOrders'] as num?)?.toInt(),
      joinScheduleDetailID: (json['joinScheduleDetailID'] as num?)?.toInt(),
      endDate: json['endDate'] as String?,
      subjectNamekh: json['subject_namekh'] as String?,
      shift: json['shift'] as String?,
      roomLab: json['roomLab'] as String?,
      typeRoomLab: json['typeRoomLab'] as String?,
      scheduleDetailID: (json['scheduleDetailID'] as num?)?.toInt(),
      teaName: json['teaName'] as String?,
      dayTimeID: (json['dayTimeID'] as num?)?.toInt(),
      dayid: (json['dayid'] as num?)?.toInt(),
      changeDate: json['changeDate'] as String?,
      subjID: (json['subjID'] as num?)?.toInt(),
      scheduleStatus: (json['scheduleStatus'] as num?)?.toInt(),
      term: (json['term'] as num?)?.toInt(),
      facultyShortName: json['facultyShortName'] as String?,
      subjectCode: json['subject_code'] as String?,
      timeId: (json['timeId'] as num?)?.toInt(),
      sex: json['sex'] as String?,
      campusFacultyID: (json['campusFacultyID'] as num?)?.toInt(),
      promotionID: (json['promotionID'] as num?)?.toInt(),
      roomID: (json['roomID'] as num?)?.toInt(),
      timeGeneral: json['timeGeneral'] as String?,
      stage: (json['stage'] as num?)?.toInt(),
      phone: json['phone'] as String?,
      goupNote: json['goupNote'] as String?,
      dayname: json['dayname'] as String?,
      labID: (json['labID'] as num?)?.toInt(),
      teaID: (json['teaID'] as num?)?.toInt(),
      subjectNameen: json['subject_nameen'] as String?,
      scheduleID: (json['scheduleID'] as num?)?.toInt(),
      startDate: json['startDate'] as String?,
      promotion: (json['promotion'] as num?)?.toInt(),
      fieldID: (json['fieldID'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ClassScheduleSubjectDataToJson(
        ClassScheduleSubjectData instance) =>
    <String, dynamic>{
      'timeOrders': instance.timeOrders,
      'joinScheduleDetailID': instance.joinScheduleDetailID,
      'endDate': instance.endDate,
      'subject_namekh': instance.subjectNamekh,
      'shift': instance.shift,
      'roomLab': instance.roomLab,
      'typeRoomLab': instance.typeRoomLab,
      'scheduleDetailID': instance.scheduleDetailID,
      'teaName': instance.teaName,
      'dayTimeID': instance.dayTimeID,
      'dayid': instance.dayid,
      'changeDate': instance.changeDate,
      'subjID': instance.subjID,
      'scheduleStatus': instance.scheduleStatus,
      'term': instance.term,
      'facultyShortName': instance.facultyShortName,
      'subject_code': instance.subjectCode,
      'timeId': instance.timeId,
      'sex': instance.sex,
      'campusFacultyID': instance.campusFacultyID,
      'promotionID': instance.promotionID,
      'roomID': instance.roomID,
      'timeGeneral': instance.timeGeneral,
      'stage': instance.stage,
      'phone': instance.phone,
      'goupNote': instance.goupNote,
      'dayname': instance.dayname,
      'labID': instance.labID,
      'teaID': instance.teaID,
      'subject_nameen': instance.subjectNameen,
      'scheduleID': instance.scheduleID,
      'startDate': instance.startDate,
      'promotion': instance.promotion,
      'fieldID': instance.fieldID,
    };
