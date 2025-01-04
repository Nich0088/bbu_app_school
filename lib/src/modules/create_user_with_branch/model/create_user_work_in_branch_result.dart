import 'package:json_annotation/json_annotation.dart';

part 'create_user_work_in_branch_result.g.dart';

@JsonSerializable()
class CreateUserWorkInBranchResult {
  CreateUserWorkInBranchResult({
    this.code,
    this.message,
    this.createUserWorkInBranchData,
  });

  @JsonKey(name: 'code')
  final int? code;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(
    name: 'data',
    fromJson: _dataFromJson,
    toJson: _dataToJson,
  )
  final dynamic createUserWorkInBranchData;

  factory CreateUserWorkInBranchResult.fromJson(Map<String, dynamic> json) =>
      _$CreateUserWorkInBranchResultFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserWorkInBranchResultToJson(this);

  static dynamic _dataFromJson(dynamic json) {
    if (json is String) {
      return json;
    } else if (json is Map<String, dynamic>) {
      return CreateUserWorkInBranchData.fromJson(json);
    }
    return null;
  }

  static dynamic _dataToJson(dynamic data) {
    if (data is String) {
      return data; // Return as String
    } else if (data is CreateUserWorkInBranchData) {
      return data.toJson(); // Convert to JSON
    }
    return null;
  }
}

@JsonSerializable()
class CreateUserWorkInBranchData {
  CreateUserWorkInBranchData({
    this.id,
    this.userId,
    this.branid,
    this.userWorkIdInBranch,
    this.branchNameEn,
    this.branchNameKh,
    this.branchShortName,
    this.usertypeId,
    this.usertypeName,
    this.userWorkStatus,
  });

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'userId')
  final String? userId;
  @JsonKey(name: 'branid')
  final int? branid;
  @JsonKey(name: 'userworkId_InBranch')
  final dynamic userWorkIdInBranch;
  @JsonKey(name: 'branch_name_en')
  final String? branchNameEn;
  @JsonKey(name: 'branch_name_kh')
  final String? branchNameKh;
  @JsonKey(name: 'branch_shortName')
  final String? branchShortName;
  @JsonKey(name: 'usertype_id')
  final int? usertypeId;
  @JsonKey(name: 'usertype_name')
  final String? usertypeName;

  @JsonKey(name: 'userwork_status')
  final bool? userWorkStatus;

  factory CreateUserWorkInBranchData.fromJson(Map<String, dynamic> json) =>
      _$CreateUserWorkInBranchDataFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserWorkInBranchDataToJson(this);
}
