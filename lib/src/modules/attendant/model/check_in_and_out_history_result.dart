import 'package:json_annotation/json_annotation.dart';

part 'check_in_and_out_history_result.g.dart';

@JsonSerializable()
class CheckInAndOutHistoryResult {
  CheckInAndOutHistoryResult({
    this.code,
    this.message,
    this.checkInAndOutHistoryData,
  });

  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'data')
  final List<CheckInAndOutHistoryData>? checkInAndOutHistoryData;

  factory CheckInAndOutHistoryResult.fromJson(Map<String, dynamic> json) =>
      _$CheckInAndOutHistoryResultFromJson(json);

  Map<String, dynamic> toJson() => _$CheckInAndOutHistoryResultToJson(this);
}

@JsonSerializable()
class CheckInAndOutHistoryData {
  CheckInAndOutHistoryData({
    this.id,
    this.studentId,
    this.day,
    this.date,
    this.subject,
    this.status,
    this.createAt,
    this.createBy,
    this.fromTime,
    this.toTime,
  });

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'studentId')
  final int? studentId;
  @JsonKey(name: 'day')
  final String? day;
  @JsonKey(name: 'date')
  final String? date;
  @JsonKey(name: 'subject')
  final String? subject;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'createAt')
  final String? createAt;
  @JsonKey(name: 'createBy')
  final String? createBy;
  @JsonKey(name: 'fromTime')
  final String? fromTime;
  @JsonKey(name: 'toTime')
  final dynamic toTime;

  factory CheckInAndOutHistoryData.fromJson(Map<String, dynamic> json) =>
      _$CheckInAndOutHistoryDataFromJson(json);

  Map<String, dynamic> toJson() => _$CheckInAndOutHistoryDataToJson(this);
}
