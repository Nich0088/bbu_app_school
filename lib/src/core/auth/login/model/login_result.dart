import 'package:json_annotation/json_annotation.dart';

part 'login_result.g.dart';

@JsonSerializable()
class LoginResult {
  LoginResult({
    this.code,
    this.message,
    this.data,
  });

  @JsonKey(name: 'code')
  final int? code;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'data')
  final LoginResultData? data;

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);
}

@JsonSerializable()
class LoginResultData {
  LoginResultData({
    this.id,
    this.userName,
    this.firstname,
    this.lastname,
    this.fullNameKh,
    this.sex,
    this.ethnicity,
    this.nationality,
    this.marriedStatus,
    this.departmentId,
    this.dob,
    this.photo,
    this.position,
    this.workplace,
    this.contactPhone,
    this.pobVillage,
    this.pobCommune,
    this.pobDistrict,
    this.pobProvince,
    this.address,
    this.telegram,
    this.status,
    this.startDateWork,
    this.nddfId,
    this.nationalId,
    this.govstaff,
  });

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'userName')
  final String? userName;
  @JsonKey(name: 'firstname')
  final String? firstname;
  @JsonKey(name: 'lastname')
  final String? lastname;
  @JsonKey(name: 'fullnamekh')
  final String? fullNameKh;
  @JsonKey(name: 'sex')
  final String? sex;
  @JsonKey(name: 'ethicity')
  final dynamic ethnicity;
  @JsonKey(name: 'nationality')
  final dynamic nationality;
  @JsonKey(name: 'marriedstatus')
  final bool? marriedStatus;
  @JsonKey(name: 'departmentid')
  final int? departmentId;
  @JsonKey(name: 'dob')
  final String? dob;
  @JsonKey(name: 'photo')
  final String? photo;
  @JsonKey(name: 'position')
  final String? position;
  @JsonKey(name: 'workplace')
  final dynamic workplace;
  @JsonKey(name: 'contactphone')
  final String? contactPhone;
  @JsonKey(name: 'pob_village')
  final dynamic pobVillage;
  @JsonKey(name: 'pob_commune')
  final dynamic pobCommune;
  @JsonKey(name: 'pob_district')
  final dynamic pobDistrict;
  @JsonKey(name: 'pob_province')
  final dynamic pobProvince;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'telegram')
  final dynamic telegram;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'startdatework')
  final dynamic startDateWork;
  @JsonKey(name: 'nddfid')
  final dynamic nddfId;
  @JsonKey(name: 'nationalid')
  final String? nationalId;
  @JsonKey(name: 'govstaff')
  final bool? govstaff;

  factory LoginResultData.fromJson(Map<String, dynamic> json) =>
      _$LoginResultDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultDataToJson(this);
}
