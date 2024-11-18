import 'package:json_annotation/json_annotation.dart';

part 'event_new_data.g.dart';

@JsonSerializable()
class EventResult {
  EventResult({
    this.eventData,
  });

  @JsonKey(name: 'data')
  final List<EventData>? eventData;

  factory EventResult.fromJson(Map<String, dynamic> json) =>
      _$EventResultFromJson(json);

  Map<String, dynamic> toJson() => _$EventResultToJson(this);
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
class EventData {
  EventData({
    this.image,
    this.title,
    this.date,
    this.description,
    this.longDescription,
    this.thumbnail,
    this.urlEventnews,
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
  @JsonKey(name: 'url_eventnews')
  final String? urlEventnews;

  factory EventData.fromJson(Map<String, dynamic> json) =>
      _$EventDataFromJson(json);

  Map<String, dynamic> toJson() => _$EventDataToJson(this);
}
