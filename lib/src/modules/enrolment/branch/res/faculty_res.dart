class FacultyRes {
  FacultyRes({
    required this.code,
    required this.message,
    required this.dataFacultyList,
  });

  int code;
  String message;
  List<DataFacultyList> dataFacultyList;

  factory FacultyRes.fromJson(Map<String, dynamic> json) => FacultyRes(
        code: json["code"],
        message: json["message"],
        dataFacultyList: json["data"] != null
            ? List<DataFacultyList>.from(
                json["data"].map((x) => DataFacultyList.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(dataFacultyList.map((x) => x.toJson())),
      };
}

class DataFacultyList {
  DataFacultyList({
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

  factory DataFacultyList.fromJson(Map<String, dynamic> json) =>
      DataFacultyList(
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
