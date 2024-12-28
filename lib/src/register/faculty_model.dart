class FacultModel {
  FacultModel({
    required this.id,
    required this.degreeId,
    required this.branchId,
    required this.name,
    required this.nameKh,
  });

  int id;
  int degreeId;
  int branchId;
  String name;
  String nameKh;

  factory FacultModel.fromJson(Map<String, dynamic> json) => FacultModel(
        id: json["id"],
        degreeId: json["degree_id"],
        branchId: json["branch_id"],
        name: json["name"],
        nameKh: json["name_kh"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "degree_id": degreeId,
        "branch_id": branchId,
        "name": name,
        "name_kh": nameKh,
      };
}
