import 'package:json_annotation/json_annotation.dart';

part 'contact.g.dart';

@JsonSerializable()
class Contact {
  Contact({
    this.data,
  });

  @JsonKey(name: 'data')
  final List<ContactData>? data;

  factory Contact.fromJson(Map<String, dynamic> json) =>
      _$ContactFromJson(json);

  Map<String, dynamic> toJson() => _$ContactToJson(this);
}

@JsonSerializable()
class ContactData {
  ContactData({
    this.campus,
    this.title,
    this.phone,
  });

  @JsonKey(name: 'campus')
  final String? campus;
  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'phone')
  final String? phone;

  factory ContactData.fromJson(Map<String, dynamic> json) =>
      _$ContactDataFromJson(json);

  Map<String, dynamic> toJson() => _$ContactDataToJson(this);
}
