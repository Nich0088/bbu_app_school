// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_new_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventResult _$EventResultFromJson(Map<String, dynamic> json) => EventResult(
      eventData: (json['data'] as List<dynamic>?)
          ?.map((e) => EventData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventResultToJson(EventResult instance) =>
    <String, dynamic>{
      'data': instance.eventData,
    };

Thumbnail _$ThumbnailFromJson(Map<String, dynamic> json) => Thumbnail(
      image: json['image'] as String?,
    );

Map<String, dynamic> _$ThumbnailToJson(Thumbnail instance) => <String, dynamic>{
      'image': instance.image,
    };

EventData _$EventDataFromJson(Map<String, dynamic> json) => EventData(
      image: json['image'] as String?,
      title: json['title'] as String?,
      date: json['date'] as String?,
      description: json['description'] as String?,
      longDescription: json['long_description'] as String?,
      thumbnail: (json['thumbnail'] as List<dynamic>?)
          ?.map((e) => Thumbnail.fromJson(e as Map<String, dynamic>))
          .toList(),
      urlEventnews: json['url_eventnews'] as String?,
    );

Map<String, dynamic> _$EventDataToJson(EventData instance) => <String, dynamic>{
      'image': instance.image,
      'title': instance.title,
      'date': instance.date,
      'description': instance.description,
      'long_description': instance.longDescription,
      'thumbnail': instance.thumbnail,
      'url_eventnews': instance.urlEventnews,
    };
