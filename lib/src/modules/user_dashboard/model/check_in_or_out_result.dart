import 'package:json_annotation/json_annotation.dart';

part 'check_in_or_out_result.g.dart';

@JsonSerializable()
class CheckInOrOutResult {
  CheckInOrOutResult({
    this.code,
    this.message,
    this.messageKH,
    this.checkInOrOutData,
    this.metadata,
  });

  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'messageKH')
  final dynamic messageKH;
  @JsonKey(name: 'data')
  final CheckInOrOutData? checkInOrOutData;
  @JsonKey(name: 'metadata')
  final dynamic metadata;

  factory CheckInOrOutResult.fromJson(Map<String, dynamic> json) =>
      _$CheckInOrOutResultFromJson(json);

  Map<String, dynamic> toJson() => _$CheckInOrOutResultToJson(this);
}

@JsonSerializable()
class CheckInOrOutData {
  CheckInOrOutData({
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
  final String? updatedBy;
  @JsonKey(name: 'createdDate')
  final String? createdDate;
  @JsonKey(name: 'updatedDate')
  final String? updatedDate;
  @JsonKey(name: 'latitude')
  final dynamic latitude;
  @JsonKey(name: 'longitude')
  final dynamic longitude;
  @JsonKey(name: 'parentId')
  final int? parentId;
  @JsonKey(name: 'checkOut')
  final dynamic checkOut;

  factory CheckInOrOutData.fromJson(Map<String, dynamic> json) =>
      _$CheckInOrOutDataFromJson(json);

  Map<String, dynamic> toJson() => _$CheckInOrOutDataToJson(this);
}
