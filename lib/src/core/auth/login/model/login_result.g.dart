// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResult _$LoginResultFromJson(Map<String, dynamic> json) => LoginResult(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : LoginResultData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResultToJson(LoginResult instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

LoginResultData _$LoginResultDataFromJson(Map<String, dynamic> json) =>
    LoginResultData(
      id: json['id'] as String?,
      userName: json['userName'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      fullNameKh: json['fullnamekh'] as String?,
      sex: json['sex'] as String?,
      ethnicity: json['ethicity'],
      nationality: json['nationality'],
      marriedStatus: json['marriedstatus'] as bool?,
      departmentId: (json['departmentid'] as num?)?.toInt(),
      dob: json['dob'] as String?,
      photo: json['photo'] as String?,
      position: json['position'] as String?,
      workplace: json['workplace'],
      contactPhone: json['contactphone'] as String?,
      pobVillage: json['pob_village'],
      pobCommune: json['pob_commune'],
      pobDistrict: json['pob_district'],
      pobProvince: json['pob_province'],
      address: json['address'] as String?,
      telegram: json['telegram'],
      status: json['status'] as String?,
      startDateWork: json['startdatework'],
      nddfId: json['nddfid'],
      nationalId: json['nationalid'] as String?,
      govstaff: json['govstaff'] as bool?,
    );

Map<String, dynamic> _$LoginResultDataToJson(LoginResultData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'fullnamekh': instance.fullNameKh,
      'sex': instance.sex,
      'ethicity': instance.ethnicity,
      'nationality': instance.nationality,
      'marriedstatus': instance.marriedStatus,
      'departmentid': instance.departmentId,
      'dob': instance.dob,
      'photo': instance.photo,
      'position': instance.position,
      'workplace': instance.workplace,
      'contactphone': instance.contactPhone,
      'pob_village': instance.pobVillage,
      'pob_commune': instance.pobCommune,
      'pob_district': instance.pobDistrict,
      'pob_province': instance.pobProvince,
      'address': instance.address,
      'telegram': instance.telegram,
      'status': instance.status,
      'startdatework': instance.startDateWork,
      'nddfid': instance.nddfId,
      'nationalid': instance.nationalId,
      'govstaff': instance.govstaff,
    };
