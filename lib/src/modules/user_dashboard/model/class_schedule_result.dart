import 'package:json_annotation/json_annotation.dart';

part 'class_schedule_result.g.dart';

@JsonSerializable()
class ClassScheduleResult {
  ClassScheduleResult({
    this.code,
    this.message,
    this.messageKH,
    this.classScheduleDataList,
    this.metadata,
  });

  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'messageKH')
  final dynamic messageKH;
  @JsonKey(name: 'data')
  final List<ClassScheduleData>? classScheduleDataList;
  @JsonKey(name: 'metadata')
  final dynamic metadata;

  factory ClassScheduleResult.fromJson(Map<String, dynamic> json) =>
      _$ClassScheduleResultFromJson(json);

  Map<String, dynamic> toJson() => _$ClassScheduleResultToJson(this);
}

@JsonSerializable()
class ClassScheduleData {
  ClassScheduleData({
    this.id,
    this.studentId,
    this.scheduleId,
    this.branchId,
    this.scheduleShortName,
    this.status,
    this.facultyShortName,
    this.startDate,
    this.endDate,
    this.roomId,
    this.roomName,
  });

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'studentId')
  final String? studentId;
  @JsonKey(name: 'scheduleId')
  final String? scheduleId;
  @JsonKey(name: 'branchId')
  final String? branchId;
  @JsonKey(name: 'scheduleShortName')
  final String? scheduleShortName;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'facultyShortName')
  final String? facultyShortName;
  @JsonKey(name: 'startDate')
  final String? startDate;
  @JsonKey(name: 'endDate')
  final String? endDate;
  @JsonKey(name: 'roomId')
  final String? roomId;
  @JsonKey(name: 'roomName')
  final String? roomName;

  factory ClassScheduleData.fromJson(Map<String, dynamic> json) =>
      _$ClassScheduleDataFromJson(json);

  Map<String, dynamic> toJson() => _$ClassScheduleDataToJson(this);
}
