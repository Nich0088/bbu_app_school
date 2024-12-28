class DegreesRes {
  DegreesRes({
    required this.code,
    required this.message,
    required this.dataListDegree,
  });

  int code;
  String message;
  List<DataDegreeList> dataListDegree;

  factory DegreesRes.fromJson(Map<String, dynamic> json) => DegreesRes(
        code: json["code"],
        message: json["message"],
        dataListDegree: json["data"] != null
            ? List<DataDegreeList>.from(
                json["data"].map((x) => DataDegreeList.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(dataListDegree.map((x) => x.toJson())),
      };
}

class DataDegreeList {
  DataDegreeList({
    required this.id,
    required this.name,
    required this.nameKh,
    this.faculties,
  });

  int id;
  String name;
  String nameKh;
  String? faculties;

  factory DataDegreeList.fromJson(Map<String, dynamic> json) => DataDegreeList(
        id: json["id"],
        name: json["name"],
        nameKh: json["name_kh"],
        faculties: json["faculties"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "name_kh": nameKh,
        "faculties": faculties,
      };
}
