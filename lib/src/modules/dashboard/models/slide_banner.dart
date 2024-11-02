import 'package:json_annotation/json_annotation.dart';

part 'slide_banner.g.dart';

@JsonSerializable()
class SlideBanner {
  SlideBanner({
    this.data,
  });

  @JsonKey(name: 'data')
  final List<Data>? data;

  factory SlideBanner.fromJson(Map<String, dynamic> json) =>
      _$SlideBannerFromJson(json);

  Map<String, dynamic> toJson() => _$SlideBannerToJson(this);
}

@JsonSerializable()
class Data {
  Data({
    this.image,
  });

  @JsonKey(name: 'image')
  final String? image;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
