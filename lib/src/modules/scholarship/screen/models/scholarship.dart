import 'package:json_annotation/json_annotation.dart';

part 'scholarship.g.dart';

@JsonSerializable()
class ScholarshipImage {
  ScholarshipImage({
    this.data,
  });

  @JsonKey(name: 'data')
  final Data? data;

  factory ScholarshipImage.fromJson(Map<String, dynamic> json) =>
      _$ScholarshipImageFromJson(json);

  Map<String, dynamic> toJson() => _$ScholarshipImageToJson(this);
}

@JsonSerializable()
class Data {
  Data({
    this.scholarship,
  });

  @JsonKey(name: 'scholarship')
  final String? scholarship;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
