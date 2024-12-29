import 'package:json_annotation/json_annotation.dart';

part 'university_branch_result.g.dart';

@JsonSerializable()
class UniversityBranchResult {
  UniversityBranchResult({
    this.code,
    this.message,
    this.universityBranchData,
  });

  @JsonKey(name: 'code')
  final int? code;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'data')
  final List<UniversityBranchData>? universityBranchData;

  factory UniversityBranchResult.fromJson(Map<String, dynamic> json) =>
      _$UniversityBranchResultFromJson(json);

  Map<String, dynamic> toJson() => _$UniversityBranchResultToJson(this);
}

@JsonSerializable()
class UniversityBranchData {
  UniversityBranchData({
    this.branchId,
    this.branchNameEn,
    this.branchNameKh,
    this.shortName,
    this.branchFax,
    this.branchTel,
  });

  @JsonKey(name: 'branch_id')
  final int? branchId;
  @JsonKey(name: 'branch_name_en')
  final String? branchNameEn;
  @JsonKey(name: 'branch_name_kh')
  final String? branchNameKh;
  @JsonKey(name: 'shortName')
  final String? shortName;
  @JsonKey(name: 'branch_fax')
  final String? branchFax;
  @JsonKey(name: 'branch_tel')
  final String? branchTel;

  factory UniversityBranchData.fromJson(Map<String, dynamic> json) =>
      _$UniversityBranchDataFromJson(json);

  Map<String, dynamic> toJson() => _$UniversityBranchDataToJson(this);
}
