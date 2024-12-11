import 'package:json_annotation/json_annotation.dart';

part 'authorize_token_result.g.dart';

@JsonSerializable()
class AuthorizeTokenResult {
  AuthorizeTokenResult({
    this.code,
    this.message,
    this.data,
  });

  @JsonKey(name: 'code')
  final int? code;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'data')
  final AuthorizeTokenData? data;

  factory AuthorizeTokenResult.fromJson(Map<String, dynamic> json) =>
      _$AuthorizeTokenResultFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorizeTokenResultToJson(this);
}

@JsonSerializable()
class AuthorizeTokenData {
  AuthorizeTokenData({
    this.id,
    this.userName,
    this.email,
    this.token,
    this.createdDate,
    this.expiredDate,
  });

  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'userName')
  final String? userName;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'token')
  final String? token;
  @JsonKey(name: 'createdate')
  final String? createdDate;
  @JsonKey(name: 'expireddate')
  final String? expiredDate;

  factory AuthorizeTokenData.fromJson(Map<String, dynamic> json) =>
      _$AuthorizeTokenDataFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorizeTokenDataToJson(this);
}
