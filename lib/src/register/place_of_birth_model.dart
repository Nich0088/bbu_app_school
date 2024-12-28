class PlaceOfBirthModel {
  String name;

  PlaceOfBirthModel({required this.name});

  factory PlaceOfBirthModel.fromJson(Map<String, dynamic> json) {
    return PlaceOfBirthModel(name: json['name_obj']);
  }
}
