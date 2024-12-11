// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorize_token_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorizeTokenResult _$AuthorizeTokenResultFromJson(
        Map<String, dynamic> json) =>
    AuthorizeTokenResult(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : AuthorizeTokenData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthorizeTokenResultToJson(
        AuthorizeTokenResult instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

AuthorizeTokenData _$AuthorizeTokenDataFromJson(Map<String, dynamic> json) =>
    AuthorizeTokenData(
      id: (json['id'] as num?)?.toInt(),
      userName: json['userName'] as String?,
      email: json['email'] as String?,
      token: json['token'] as String?,
      createdDate: json['createdate'] as String?,
      expiredDate: json['expireddate'] as String?,
    );

Map<String, dynamic> _$AuthorizeTokenDataToJson(AuthorizeTokenData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'email': instance.email,
      'token': instance.token,
      'createdate': instance.createdDate,
      'expireddate': instance.expiredDate,
    };
