import 'package:json_annotation/json_annotation.dart';

part 'student_score_result.g.dart';

@JsonSerializable()
class StudentScoreResult {
  StudentScoreResult({
    this.code,
    this.message,
    this.studentScore,
    this.degree,
    this.footerFormat,
  });

  @JsonKey(name: 'code')
  final int? code;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'studentscore')
  final List<StudentScore>? studentScore;
  @JsonKey(name: 'degree')
  final List<Degree>? degree;
  @JsonKey(name: 'footerFormat')
  final String? footerFormat;

  factory StudentScoreResult.fromJson(Map<String, dynamic> json) =>
      _$StudentScoreResultFromJson(json);

  Map<String, dynamic> toJson() => _$StudentScoreResultToJson(this);
}

@JsonSerializable()
class StudentScore {
  StudentScore({
    this.term,
    this.subjectName,
    this.credit,
    this.midtermResult,
    this.finalResult,
    this.totalResult,
    this.grade,
  });

  @JsonKey(name: 'term')
  final String? term;
  @JsonKey(name: 'subject_name')
  final String? subjectName;
  @JsonKey(name: 'credit')
  final String? credit;
  @JsonKey(name: 'midterm')
  final double? midtermResult;
  @JsonKey(name: 'final')
  final double? finalResult;
  @JsonKey(name: 'total')
  final double? totalResult;
  @JsonKey(name: 'grade')
  final String? grade;

  factory StudentScore.fromJson(Map<String, dynamic> json) =>
      _$StudentScoreFromJson(json);

  Map<String, dynamic> toJson() => _$StudentScoreToJson(this);
}

@JsonSerializable()
class Degree {
  Degree({
    this.degreeId,
    this.degreeNameEn,
    this.degreeNameKh,
  });

  @JsonKey(name: 'degreeid')
  final int? degreeId;
  @JsonKey(name: 'degree_name_en')
  final String? degreeNameEn;
  @JsonKey(name: 'degree_name_kh')
  final String? degreeNameKh;

  factory Degree.fromJson(Map<String, dynamic> json) => _$DegreeFromJson(json);

  Map<String, dynamic> toJson() => _$DegreeToJson(this);
}
