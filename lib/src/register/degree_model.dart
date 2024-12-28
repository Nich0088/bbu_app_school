import 'faculty_model.dart';

class DegreeModel {
  int id;
  String name;
  String nameKh;
  int branchid;
  List<FacultModel>? facultModelList;

  DegreeModel(
      {required this.id,
      required this.name,
      required this.nameKh,
      this.facultModelList,
      required this.branchid});

  factory DegreeModel.fromJson(Map<String, dynamic> json) => DegreeModel(
        id: json["id"],
        name: json["name"],
        nameKh: json["name_kh"],
        branchid: json["branch_id"],
        facultModelList: json["faculties"] != null
            ? List<FacultModel>.from(
                json["faculties"].map((x) => FacultModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "name_kh": nameKh,
        "branch_id": branchid,
        "faculties":
            List<dynamic>.from(facultModelList!.map((x) => x.toJson())),
      };
}
