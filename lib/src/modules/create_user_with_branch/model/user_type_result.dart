import 'package:json_annotation/json_annotation.dart';

part 'user_type_result.g.dart';

@JsonSerializable()
class UserTypeResult {
  UserTypeResult({
    this.code,
    this.message,
    this.userTypeData,
  });

  @JsonKey(name: 'code')
  final int? code;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'data')
  final List<UserTypeData>? userTypeData;

  factory UserTypeResult.fromJson(Map<String, dynamic> json) =>
      _$UserTypeResultFromJson(json);

  Map<String, dynamic> toJson() => _$UserTypeResultToJson(this);
}

@JsonSerializable()
class UserTypeData {
  UserTypeData({
    this.id,
    this.usertypeName,
    this.usertypeStatus,
  });

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'usertype_name')
  final String? usertypeName;
  @JsonKey(name: 'usertype_status')
  final bool? usertypeStatus;

  factory UserTypeData.fromJson(Map<String, dynamic> json) =>
      _$UserTypeDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserTypeDataToJson(this);
}
