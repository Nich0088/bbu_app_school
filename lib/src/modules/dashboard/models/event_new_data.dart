import 'package:json_annotation/json_annotation.dart';

part 'event_new_data.g.dart';

@JsonSerializable()
class EventList {
  EventList({
    this.data,
  });

  @JsonKey(name: 'data')
  final List<Data>? data;

  factory EventList.fromJson(Map<String, dynamic> json) =>
      _$EventListFromJson(json);

  Map<String, dynamic> toJson() => _$EventListToJson(this);
}

@JsonSerializable()
class Thumbnail {
  Thumbnail({
    this.image,
  });

  @JsonKey(name: 'image')
  final String? image;

  factory Thumbnail.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailFromJson(json);

  Map<String, dynamic> toJson() => _$ThumbnailToJson(this);
}

@JsonSerializable()
class Data {
  Data({
    this.image,
    this.title,
    this.date,
    this.description,
    this.longDescription,
    this.thumbnail,
  });

  @JsonKey(name: 'image')
  final String? image;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'date')
  final String? date;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'long_description')
  final String? longDescription;
  @JsonKey(name: 'thumbnail')
  final List<Thumbnail>? thumbnail;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
