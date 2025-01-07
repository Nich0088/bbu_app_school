import 'package:json_annotation/json_annotation.dart';

part 'class_time_schedule_result.g.dart';

@JsonSerializable()
class ClassTimeScheduleResult {
  ClassTimeScheduleResult({
    this.message,
    this.classTimeScheduleDataList,
  });

  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'data')
  final List<ClassTimeScheduleData>? classTimeScheduleDataList;

  factory ClassTimeScheduleResult.fromJson(Map<String, dynamic> json) =>
      _$ClassTimeScheduleResultFromJson(json);

  Map<String, dynamic> toJson() => _$ClassTimeScheduleResultToJson(this);
}

@JsonSerializable()
class ClassTimeScheduleData {
  ClassTimeScheduleData({
    this.scheduleDetailID,
    this.scheduleID,
    this.promotionID,
    this.promotion,
    this.stage,
    this.term,
    this.teaID,
    this.subjID,
    this.roomID,
    this.labID,
    this.dayTimeID,
    this.joinScheduleDetailID,
    this.fieldID,
    this.campusFacultyID,
    this.scheduleStatus,
    this.dayId,
    this.timeId,
    this.timeOrders,
    this.teaName,
    this.sex,
    this.phone,
    this.goupNote,
    this.facultyShortName,
    this.roomLab,
    this.typeRoomLab,
    this.dayName,
    this.timeGeneral,
    this.shift,
    this.startDate,
    this.endDate,
    this.subjectCode,
    this.subjectNameEn,
    this.subjectNameKh,
  });

  @JsonKey(name: 'scheduleDetailID')
  final int? scheduleDetailID;
  @JsonKey(name: 'scheduleID')
  final int? scheduleID;
  @JsonKey(name: 'promotionID')
  final int? promotionID;
  @JsonKey(name: 'promotion')
  final int? promotion;
  @JsonKey(name: 'stage')
  final int? stage;
  @JsonKey(name: 'term')
  final int? term;
  @JsonKey(name: 'teaID')
  final int? teaID;
  @JsonKey(name: 'subjID')
  final int? subjID;
  @JsonKey(name: 'roomID')
  final int? roomID;
  @JsonKey(name: 'labID')
  final int? labID;
  @JsonKey(name: 'dayTimeID')
  final int? dayTimeID;
  @JsonKey(name: 'joinScheduleDetailID')
  final int? joinScheduleDetailID;
  @JsonKey(name: 'fieldID')
  final int? fieldID;
  @JsonKey(name: 'campusFacultyID')
  final int? campusFacultyID;
  @JsonKey(name: 'scheduleStatus')
  final int? scheduleStatus;
  @JsonKey(name: 'dayid')
  final int? dayId;
  @JsonKey(name: 'timeId')
  final int? timeId;
  @JsonKey(name: 'timeOrders')
  final int? timeOrders;
  @JsonKey(name: 'teaName')
  final String? teaName;
  @JsonKey(name: 'sex')
  final String? sex;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'goupNote')
  final String? goupNote;
  @JsonKey(name: 'facultyShortName')
  final String? facultyShortName;
  @JsonKey(name: 'roomLab')
  final String? roomLab;
  @JsonKey(name: 'typeRoomLab')
  final String? typeRoomLab;
  @JsonKey(name: 'dayname')
  final String? dayName;
  @JsonKey(name: 'timeGeneral')
  final String? timeGeneral;
  @JsonKey(name: 'shift')
  final String? shift;
  @JsonKey(name: 'startDate')
  final String? startDate;
  @JsonKey(name: 'endDate')
  final String? endDate;
  @JsonKey(name: 'subject_code')
  final String? subjectCode;
  @JsonKey(name: 'subject_nameen')
  final String? subjectNameEn;
  @JsonKey(name: 'subject_namekh')
  final String? subjectNameKh;

  factory ClassTimeScheduleData.fromJson(Map<String, dynamic> json) =>
      _$ClassTimeScheduleDataFromJson(json);

  Map<String, dynamic> toJson() => _$ClassTimeScheduleDataToJson(this);
}
