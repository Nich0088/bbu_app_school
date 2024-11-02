// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slide_banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlideBanner _$SlideBannerFromJson(Map<String, dynamic> json) => SlideBanner(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SlideBannerToJson(SlideBanner instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      image: json['image'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'image': instance.image,
    };
