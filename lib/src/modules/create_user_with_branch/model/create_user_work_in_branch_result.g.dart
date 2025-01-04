// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_user_work_in_branch_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUserWorkInBranchResult _$CreateUserWorkInBranchResultFromJson(
        Map<String, dynamic> json) =>
    CreateUserWorkInBranchResult(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      createUserWorkInBranchData:
          CreateUserWorkInBranchResult._dataFromJson(json['data']),
    );

Map<String, dynamic> _$CreateUserWorkInBranchResultToJson(
        CreateUserWorkInBranchResult instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': CreateUserWorkInBranchResult._dataToJson(
          instance.createUserWorkInBranchData),
    };

CreateUserWorkInBranchData _$CreateUserWorkInBranchDataFromJson(
        Map<String, dynamic> json) =>
    CreateUserWorkInBranchData(
      id: (json['id'] as num?)?.toInt(),
      userId: json['userId'] as String?,
      branid: (json['branid'] as num?)?.toInt(),
      userWorkIdInBranch: json['userworkId_InBranch'],
      branchNameEn: json['branch_name_en'] as String?,
      branchNameKh: json['branch_name_kh'] as String?,
      branchShortName: json['branch_shortName'] as String?,
      usertypeId: (json['usertype_id'] as num?)?.toInt(),
      usertypeName: json['usertype_name'] as String?,
      userWorkStatus: json['userwork_status'] as bool?,
    );

Map<String, dynamic> _$CreateUserWorkInBranchDataToJson(
        CreateUserWorkInBranchData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'branid': instance.branid,
      'userworkId_InBranch': instance.userWorkIdInBranch,
      'branch_name_en': instance.branchNameEn,
      'branch_name_kh': instance.branchNameKh,
      'branch_shortName': instance.branchShortName,
      'usertype_id': instance.usertypeId,
      'usertype_name': instance.usertypeName,
      'userwork_status': instance.userWorkStatus,
    };
