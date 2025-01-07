// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_score_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentScoreResult _$StudentScoreResultFromJson(Map<String, dynamic> json) =>
    StudentScoreResult(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      studentScore: (json['studentscore'] as List<dynamic>?)
          ?.map((e) => StudentScore.fromJson(e as Map<String, dynamic>))
          .toList(),
      degree: (json['degree'] as List<dynamic>?)
          ?.map((e) => Degree.fromJson(e as Map<String, dynamic>))
          .toList(),
      footerFormat: json['footerFormat'] as String?,
    );

Map<String, dynamic> _$StudentScoreResultToJson(StudentScoreResult instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'studentscore': instance.studentScore,
      'degree': instance.degree,
      'footerFormat': instance.footerFormat,
    };

StudentScore _$StudentScoreFromJson(Map<String, dynamic> json) => StudentScore(
      term: json['term'] as String?,
      subjectName: json['subject_name'] as String?,
      credit: json['credit'] as String?,
      midtermResult: (json['midterm'] as num?)?.toDouble(),
      finalResult: (json['final'] as num?)?.toDouble(),
      totalResult: (json['total'] as num?)?.toDouble(),
      grade: json['grade'] as String?,
    );

Map<String, dynamic> _$StudentScoreToJson(StudentScore instance) =>
    <String, dynamic>{
      'term': instance.term,
      'subject_name': instance.subjectName,
      'credit': instance.credit,
      'midterm': instance.midtermResult,
      'final': instance.finalResult,
      'total': instance.totalResult,
      'grade': instance.grade,
    };

Degree _$DegreeFromJson(Map<String, dynamic> json) => Degree(
      degreeId: (json['degreeid'] as num?)?.toInt(),
      degreeNameEn: json['degree_name_en'] as String?,
      degreeNameKh: json['degree_name_kh'] as String?,
    );

Map<String, dynamic> _$DegreeToJson(Degree instance) => <String, dynamic>{
      'degreeid': instance.degreeId,
      'degree_name_en': instance.degreeNameEn,
      'degree_name_kh': instance.degreeNameKh,
    };
