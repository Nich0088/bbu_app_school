import 'package:json_annotation/json_annotation.dart';

part 'campuses.g.dart';

@JsonSerializable()
class Campuses {
  Campuses({
    this.campuses,
  });

  @JsonKey(name: 'campuses')
  final List<CampusesData>? campuses;

  factory Campuses.fromJson(Map<String, dynamic> json) =>
      _$CampusesFromJson(json);

  Map<String, dynamic> toJson() => _$CampusesToJson(this);
}

@JsonSerializable()
class CampusesData {
  CampusesData({
    this.campus,
    this.tel,
    this.email,
    this.address,
    this.imgPath,
  });

  @JsonKey(name: 'campus')
  final String? campus;
  @JsonKey(name: 'tel')
  final String? tel;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: 'img_path')
  final String? imgPath;

  factory CampusesData.fromJson(Map<String, dynamic> json) =>
      _$CampusesDataFromJson(json);

  Map<String, dynamic> toJson() => _$CampusesDataToJson(this);
}
