class BranchRes {
  BranchRes({
    required this.code,
    required this.message,
    required this.dataBranchList,
  });

  int code;
  String message;
  List<DataBranchList> dataBranchList;

  factory BranchRes.fromJson(Map<String, dynamic> json) => BranchRes(
        code: json["code"],
        message: json["message"],
        dataBranchList: json["data"] != null
            ? List<DataBranchList>.from(
                json["data"].map((x) => DataBranchList.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(dataBranchList.map((x) => x.toJson())),
      };
}

class DataBranchList {
  DataBranchList({
    required this.id,
    required this.name,
    required this.nameKh,
    this.degreses,
  });

  int id;
  String name;
  String nameKh;
  String? degreses;

  factory DataBranchList.fromJson(Map<String, dynamic> json) => DataBranchList(
        id: json["id"],
        name: json["name"],
        nameKh: json["name_kh"],
        degreses: json["degreses"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "name_kh": nameKh,
        "degreses": degreses,
      };
}
