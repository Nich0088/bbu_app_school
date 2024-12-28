class ProvinceRes {
  ProvinceRes({
    required this.code,
    required this.message,
    required this.dataList,
  });

  int code;
  String message;
  List<ProvinceModel> dataList;

  factory ProvinceRes.fromJson(Map<String, dynamic> json) => ProvinceRes(
        code: json["code"],
        message: json["message"],
        dataList: List<ProvinceModel>.from(
            json["data"].map((x) => ProvinceModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(dataList.map((x) => x.toJson())),
      };
}

class ProvinceModel {
  ProvinceModel({
    required this.nameObj,
  });

  String nameObj;

  factory ProvinceModel.fromJson(Map<String, dynamic> json) => ProvinceModel(
        nameObj: json["name_obj"],
      );

  Map<String, dynamic> toJson() => {
        "name_obj": nameObj,
      };
}
