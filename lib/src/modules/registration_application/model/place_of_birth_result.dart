import 'package:json_annotation/json_annotation.dart';

part 'place_of_birth_result.g.dart';

@JsonSerializable()
class PlaceOfBirthResult {
  PlaceOfBirthResult({
    this.code,
    this.message,
    this.placeOfBirthData,
  });

  @JsonKey(name: 'code')
  final int? code;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'data')
  final List<PlaceOfBirthData>? placeOfBirthData;

  factory PlaceOfBirthResult.fromJson(Map<String, dynamic> json) =>
      _$PlaceOfBirthResultFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceOfBirthResultToJson(this);
}

@JsonSerializable()
class PlaceOfBirthData {
  PlaceOfBirthData({
    this.nameObj,
  });

  @JsonKey(name: 'name_obj')
  final String? nameObj;

  factory PlaceOfBirthData.fromJson(Map<String, dynamic> json) =>
      _$PlaceOfBirthDataFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceOfBirthDataToJson(this);
}
