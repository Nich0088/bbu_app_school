import 'package:json_annotation/json_annotation.dart';

part 'check_in_and_out_history_result.g.dart';

@JsonSerializable()
class CheckInAndOutHistoryResult {
  CheckInAndOutHistoryResult({
    this.code,
    this.message,
    this.messageKH,
    this.checkInAndOutHistoryDataList,
    this.metadata,
  });

  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'messageKH')
  final dynamic messageKH;
  @JsonKey(name: 'data')
  final List<CheckInAndOutHistoryData>? checkInAndOutHistoryDataList;
  @JsonKey(name: 'metadata')
  final dynamic metadata;

  factory CheckInAndOutHistoryResult.fromJson(Map<String, dynamic> json) =>
      _$CheckInAndOutHistoryResultFromJson(json);

  Map<String, dynamic> toJson() => _$CheckInAndOutHistoryResultToJson(this);
}

@JsonSerializable()
class CheckInAndOutHistoryData {
  CheckInAndOutHistoryData({
    this.id,
    this.studentId,
    this.scheduleId,
    this.subjectId,
    this.checkInDate,
    this.checkOutDate,
    this.checkStatus,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.createdDate,
    this.updatedDate,
    this.latitude,
    this.longitude,
    this.parentId,
    this.checkOut,
  });

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'studentId')
  final String? studentId;
  @JsonKey(name: 'scheduleId')
  final String? scheduleId;
  @JsonKey(name: 'subjectId')
  final String? subjectId;
  @JsonKey(name: 'checkInDate')
  final String? checkInDate;
  @JsonKey(name: 'checkOutDate')
  final dynamic checkOutDate;
  @JsonKey(name: 'checkStatus')
  final String? checkStatus;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'createdBy')
  final String? createdBy;
  @JsonKey(name: 'updatedBy')
  final dynamic updatedBy;
  @JsonKey(name: 'createdDate')
  final String? createdDate;
  @JsonKey(name: 'updatedDate')
  final dynamic updatedDate;
  @JsonKey(name: 'latitude')
  final dynamic latitude;
  @JsonKey(name: 'longitude')
  final dynamic longitude;
  @JsonKey(name: 'parentId')
  final int? parentId;
  @JsonKey(name: 'checkOut')
  final dynamic checkOut;

  factory CheckInAndOutHistoryData.fromJson(Map<String, dynamic> json) =>
      _$CheckInAndOutHistoryDataFromJson(json);

  Map<String, dynamic> toJson() => _$CheckInAndOutHistoryDataToJson(this);
}
