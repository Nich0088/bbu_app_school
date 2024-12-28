import 'degree_model.dart';

class BranchModel {
  BranchModel({
    required this.id,
    required this.name,
    required this.nameKh,
    this.degreeModelList,
  });

  int id;
  String name;
  String nameKh;
  List<DegreeModel>? degreeModelList;

  factory BranchModel.fromJson(Map<String, dynamic> json) => BranchModel(
        id: json["id"],
        name: json["name"],
        nameKh: json["name_kh"],
        degreeModelList: json["degreses"] != null
            ? List<DegreeModel>.from(
                json["degreses"].map((x) => DegreeModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "name_kh": nameKh,
        "degreses": List<dynamic>.from(degreeModelList!.map((x) => x.toJson())),
      };
}
