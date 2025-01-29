import 'package:json_annotation/json_annotation.dart';

part 'class_schedule_subject_result.g.dart';

@JsonSerializable()
class ClassScheduleSubjectResult {
  ClassScheduleSubjectResult({
    this.code,
    this.message,
    this.messageKH,
    this.classScheduleSubjectData,
    this.metadata,
  });

  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'messageKH')
  final dynamic messageKH;
  @JsonKey(name: 'data')
  final List<ClassScheduleSubjectData>? classScheduleSubjectData;
  @JsonKey(name: 'metadata')
  final dynamic metadata;

  factory ClassScheduleSubjectResult.fromJson(Map<String, dynamic> json) =>
      _$ClassScheduleSubjectResultFromJson(json);

  Map<String, dynamic> toJson() => _$ClassScheduleSubjectResultToJson(this);
}

@JsonSerializable()
class ClassScheduleSubjectData {
  ClassScheduleSubjectData({
    this.timeOrders,
    this.joinScheduleDetailID,
    this.endDate,
    this.subjectNamekh,
    this.shift,
    this.roomLab,
    this.typeRoomLab,
    this.scheduleDetailID,
    this.teaName,
    this.dayTimeID,
    this.dayid,
    this.changeDate,
    this.subjID,
    this.scheduleStatus,
    this.term,
    this.facultyShortName,
    this.subjectCode,
    this.timeId,
    this.sex,
    this.campusFacultyID,
    this.promotionID,
    this.roomID,
    this.timeGeneral,
    this.stage,
    this.phone,
    this.goupNote,
    this.dayname,
    this.labID,
    this.teaID,
    this.subjectNameen,
    this.scheduleID,
    this.startDate,
    this.promotion,
    this.fieldID,
  });

  @JsonKey(name: 'timeOrders')
  final int? timeOrders;
  @JsonKey(name: 'joinScheduleDetailID')
  final int? joinScheduleDetailID;
  @JsonKey(name: 'endDate')
  final String? endDate;
  @JsonKey(name: 'subject_namekh')
  final String? subjectNamekh;
  @JsonKey(name: 'shift')
  final String? shift;
  @JsonKey(name: 'roomLab')
  final String? roomLab;
  @JsonKey(name: 'typeRoomLab')
  final String? typeRoomLab;
  @JsonKey(name: 'scheduleDetailID')
  final int? scheduleDetailID;
  @JsonKey(name: 'teaName')
  final String? teaName;
  @JsonKey(name: 'dayTimeID')
  final int? dayTimeID;
  @JsonKey(name: 'dayid')
  final int? dayid;
  @JsonKey(name: 'changeDate')
  final String? changeDate;
  @JsonKey(name: 'subjID')
  final int? subjID;
  @JsonKey(name: 'scheduleStatus')
  final int? scheduleStatus;
  @JsonKey(name: 'term')
  final int? term;
  @JsonKey(name: 'facultyShortName')
  final String? facultyShortName;
  @JsonKey(name: 'subject_code')
  final String? subjectCode;
  @JsonKey(name: 'timeId')
  final int? timeId;
  @JsonKey(name: 'sex')
  final String? sex;
  @JsonKey(name: 'campusFacultyID')
  final int? campusFacultyID;
  @JsonKey(name: 'promotionID')
  final int? promotionID;
  @JsonKey(name: 'roomID')
  final int? roomID;
  @JsonKey(name: 'timeGeneral')
  final String? timeGeneral;
  @JsonKey(name: 'stage')
  final int? stage;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'goupNote')
  final String? goupNote;
  @JsonKey(name: 'dayname')
  final String? dayname;
  @JsonKey(name: 'labID')
  final int? labID;
  @JsonKey(name: 'teaID')
  final int? teaID;
  @JsonKey(name: 'subject_nameen')
  final String? subjectNameen;
  @JsonKey(name: 'scheduleID')
  final int? scheduleID;
  @JsonKey(name: 'startDate')
  final String? startDate;
  @JsonKey(name: 'promotion')
  final int? promotion;
  @JsonKey(name: 'fieldID')
  final int? fieldID;

  factory ClassScheduleSubjectData.fromJson(Map<String, dynamic> json) =>
      _$ClassScheduleSubjectDataFromJson(json);

  Map<String, dynamic> toJson() => _$ClassScheduleSubjectDataToJson(this);
}
