import 'package:json_annotation/json_annotation.dart';

part 'student_profile_result.g.dart';

@JsonSerializable()
class StudentProfileResult {
  StudentProfileResult({
    this.code,
    this.message,
    this.studentProfileData,
  });

  @JsonKey(name: 'code')
  final int? code;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'data')
  final StudentProfileData? studentProfileData;

  factory StudentProfileResult.fromJson(Map<String, dynamic> json) =>
      _$StudentProfileResultFromJson(json);

  Map<String, dynamic> toJson() => _$StudentProfileResultToJson(this);
}

@JsonSerializable()
class StudentProfileData {
  StudentProfileData({
    this.studentId,
    this.studentIdTemp,
    this.studentNameEn,
    this.studentNameKh,
    this.firstNameEn,
    this.firstNameKh,
    this.lastNameEn,
    this.lastNameKh,
    this.sex,
    this.dateOfBirth,
    this.placeOfBirth,
    this.photo,
    this.photoUrl,
    this.phone,
    this.email,
    this.branchNameEn,
    this.branchNameKh,
    this.specializationEn,
    this.specializationKh,
    this.degreeEn,
    this.degreeKh,
    this.facultyEn,
    this.facultyKh,
    this.chooseAcademicPrice,
    this.studyTime,
    this.groupName,
    this.termNo,
  });

  @JsonKey(name: 'studentid')
  final String? studentId;
  @JsonKey(name: 'student_id_temp')
  final String? studentIdTemp;
  @JsonKey(name: 'student_name_en')
  final String? studentNameEn;
  @JsonKey(name: 'student_name_kh')
  final String? studentNameKh;
  @JsonKey(name: 'first_name_en')
  final String? firstNameEn;
  @JsonKey(name: 'first_name_kh')
  final String? firstNameKh;
  @JsonKey(name: 'last_name_en')
  final String? lastNameEn;
  @JsonKey(name: 'last_name_kh')
  final String? lastNameKh;
  @JsonKey(name: 'sex')
  final String? sex;
  @JsonKey(name: 'date_of_birth')
  final String? dateOfBirth;
  @JsonKey(name: 'place_of_birth')
  final String? placeOfBirth;
  @JsonKey(name: 'photo')
  final String? photo;
  @JsonKey(name: 'photo_url')
  final String? photoUrl;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'branch_name_en')
  final String? branchNameEn;
  @JsonKey(name: 'branch_name_kh')
  final String? branchNameKh;
  @JsonKey(name: 'specialization_en')
  final String? specializationEn;
  @JsonKey(name: 'specialization_kh')
  final String? specializationKh;
  @JsonKey(name: 'degree_en')
  final String? degreeEn;
  @JsonKey(name: 'degree_kh')
  final String? degreeKh;
  @JsonKey(name: 'faculty_en')
  final String? facultyEn;
  @JsonKey(name: 'faculty_kh')
  final String? facultyKh;
  @JsonKey(name: 'choose_academic_price')
  final int? chooseAcademicPrice;
  @JsonKey(name: 'study_time')
  final String? studyTime;
  @JsonKey(name: 'group_name')
  final String? groupName;
  @JsonKey(name: 'term_no')
  final int? termNo;

  factory StudentProfileData.fromJson(Map<String, dynamic> json) =>
      _$StudentProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$StudentProfileDataToJson(this);
}
