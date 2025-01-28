import 'package:json_annotation/json_annotation.dart';

part 'class_schedule_link_result.g.dart';

@JsonSerializable()
class ClassScheduleLinkResult {
  ClassScheduleLinkResult({
    this.code,
    this.message,
    this.messageKH,
  });

  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'messageKH')
  final String? messageKH;

  factory ClassScheduleLinkResult.fromJson(Map<String, dynamic> json) =>
      _$ClassScheduleLinkResultFromJson(json);

  Map<String, dynamic> toJson() => _$ClassScheduleLinkResultToJson(this);
}
