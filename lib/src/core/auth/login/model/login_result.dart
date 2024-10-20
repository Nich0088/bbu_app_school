import 'package:json_annotation/json_annotation.dart';

part 'login_result.g.dart';

@JsonSerializable()
class LoginResult {
  LoginResult({
    this.code,
    this.message,
    this.data,
  });

  @JsonKey(name: 'code')
  final int? code;
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'data')
  final LoginData? data;

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);
}

@JsonSerializable()
class LoginData {
  LoginData({
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

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}
