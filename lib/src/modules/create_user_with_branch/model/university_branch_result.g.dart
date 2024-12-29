// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'university_branch_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UniversityBranchResult _$UniversityBranchResultFromJson(
        Map<String, dynamic> json) =>
    UniversityBranchResult(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      universityBranchData: (json['data'] as List<dynamic>?)
          ?.map((e) => UniversityBranchData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UniversityBranchResultToJson(
        UniversityBranchResult instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.universityBranchData,
    };

UniversityBranchData _$UniversityBranchDataFromJson(
        Map<String, dynamic> json) =>
    UniversityBranchData(
      branchId: (json['branch_id'] as num?)?.toInt(),
      branchNameEn: json['branch_name_en'] as String?,
      branchNameKh: json['branch_name_kh'] as String?,
      shortName: json['shortName'] as String?,
      branchFax: json['branch_fax'] as String?,
      branchTel: json['branch_tel'] as String?,
    );

Map<String, dynamic> _$UniversityBranchDataToJson(
        UniversityBranchData instance) =>
    <String, dynamic>{
      'branch_id': instance.branchId,
      'branch_name_en': instance.branchNameEn,
      'branch_name_kh': instance.branchNameKh,
      'shortName': instance.shortName,
      'branch_fax': instance.branchFax,
      'branch_tel': instance.branchTel,
    };
