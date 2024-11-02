// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ContactData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'data': instance.data,
    };

ContactData _$ContactDataFromJson(Map<String, dynamic> json) => ContactData(
      campus: json['campus'] as String?,
      title: json['title'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$ContactDataToJson(ContactData instance) =>
    <String, dynamic>{
      'campus': instance.campus,
      'title': instance.title,
      'phone': instance.phone,
    };
