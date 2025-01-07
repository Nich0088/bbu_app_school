// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_profile_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentProfileResult _$StudentProfileResultFromJson(
        Map<String, dynamic> json) =>
    StudentProfileResult(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      studentProfileData: json['data'] == null
          ? null
          : StudentProfileData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StudentProfileResultToJson(
        StudentProfileResult instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.studentProfileData,
    };

StudentProfileData _$StudentProfileDataFromJson(Map<String, dynamic> json) =>
    StudentProfileData(
      studentId: json['studentid'] as String?,
      studentIdTemp: json['student_id_temp'] as String?,
      studentNameEn: json['student_name_en'] as String?,
      studentNameKh: json['student_name_kh'] as String?,
      firstNameEn: json['first_name_en'] as String?,
      firstNameKh: json['first_name_kh'] as String?,
      lastNameEn: json['last_name_en'] as String?,
      lastNameKh: json['last_name_kh'] as String?,
      sex: json['sex'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      placeOfBirth: json['place_of_birth'] as String?,
      photo: json['photo'] as String?,
      photoUrl: json['photo_url'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      branchNameEn: json['branch_name_en'] as String?,
      branchNameKh: json['branch_name_kh'] as String?,
      specializationEn: json['specialization_en'] as String?,
      specializationKh: json['specialization_kh'] as String?,
      degreeEn: json['degree_en'] as String?,
      degreeKh: json['degree_kh'] as String?,
      facultyEn: json['faculty_en'] as String?,
      facultyKh: json['faculty_kh'] as String?,
      chooseAcademicPrice: (json['choose_academic_price'] as num?)?.toInt(),
      studyTime: json['study_time'] as String?,
      groupName: json['group_name'] as String?,
      termNo: (json['term_no'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StudentProfileDataToJson(StudentProfileData instance) =>
    <String, dynamic>{
      'studentid': instance.studentId,
      'student_id_temp': instance.studentIdTemp,
      'student_name_en': instance.studentNameEn,
      'student_name_kh': instance.studentNameKh,
      'first_name_en': instance.firstNameEn,
      'first_name_kh': instance.firstNameKh,
      'last_name_en': instance.lastNameEn,
      'last_name_kh': instance.lastNameKh,
      'sex': instance.sex,
      'date_of_birth': instance.dateOfBirth,
      'place_of_birth': instance.placeOfBirth,
      'photo': instance.photo,
      'photo_url': instance.photoUrl,
      'phone': instance.phone,
      'email': instance.email,
      'branch_name_en': instance.branchNameEn,
      'branch_name_kh': instance.branchNameKh,
      'specialization_en': instance.specializationEn,
      'specialization_kh': instance.specializationKh,
      'degree_en': instance.degreeEn,
      'degree_kh': instance.degreeKh,
      'faculty_en': instance.facultyEn,
      'faculty_kh': instance.facultyKh,
      'choose_academic_price': instance.chooseAcademicPrice,
      'study_time': instance.studyTime,
      'group_name': instance.groupName,
      'term_no': instance.termNo,
    };
