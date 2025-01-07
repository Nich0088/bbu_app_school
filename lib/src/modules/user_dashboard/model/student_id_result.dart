import 'package:json_annotation/json_annotation.dart';

part 'student_id_result.g.dart';

@JsonSerializable()
class StudentIdResult {
  StudentIdResult({
    this.code,
    this.message,
    this.data,
  });

  @JsonKey(name: 'code')
  final int? code;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'data')
  final List<String>? data;

  factory StudentIdResult.fromJson(Map<String, dynamic> json) =>
      _$StudentIdResultFromJson(json);

  Map<String, dynamic> toJson() => _$StudentIdResultToJson(this);
}
