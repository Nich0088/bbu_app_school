class SpecializationRes {
  SpecializationRes({
    required this.code,
    required this.message,
    required this.specializationModelList,
  });

  int code;
  String message;
  List<SpecializationModel> specializationModelList;

  factory SpecializationRes.fromJson(Map<String, dynamic> json) =>
      SpecializationRes(
        code: json["code"],
        message: json["message"],
        specializationModelList: json["data"] != null
            ? List<SpecializationModel>.from(
                json["data"].map((x) => SpecializationModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data":
            List<dynamic>.from(specializationModelList.map((x) => x.toJson())),
      };
}

class SpecializationModel {
  SpecializationModel({
    required this.id,
    required this.name,
    required this.nameKh,
    required this.priceChooseList,
    required this.timeStudiesList,
  });

  int id;
  String name;
  String nameKh;
  List<PriceChooseModel> priceChooseList;
  List<TimeStudyModel> timeStudiesList;

  factory SpecializationModel.fromJson(Map<String, dynamic> json) =>
      SpecializationModel(
        id: json["id"],
        name: json["name"],
        nameKh: json["name_kh"],
        priceChooseList: json["price_choose"] != null
            ? List<PriceChooseModel>.from(
                json["price_choose"].map((x) => PriceChooseModel.fromJson(x)))
            : [],
        timeStudiesList: json["time_studies"] != null
            ? List<TimeStudyModel>.from(
                json["time_studies"].map((x) => TimeStudyModel.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "name_kh": nameKh,
        "price_choose":
            List<dynamic>.from(priceChooseList.map((x) => x.toJson())),
        "time_studies":
            List<dynamic>.from(timeStudiesList.map((x) => x.toJson())),
      };
}

class PriceChooseModel {
  PriceChooseModel({
    required this.price,
    required this.namePrice,
    required this.namePriceKh,
  });

  double price;
  String namePrice;
  String namePriceKh;

  factory PriceChooseModel.fromJson(Map<String, dynamic> json) =>
      PriceChooseModel(
        price: json["price"],
        namePrice: json["name_price"],
        namePriceKh: json["name_price_kh"],
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "name_price": namePrice,
        "name_price_kh": namePriceKh,
      };
}

class TimeStudyModel {
  TimeStudyModel({
    required this.id,
    required this.studyTime,
  });

  int id;
  String studyTime;

  factory TimeStudyModel.fromJson(Map<String, dynamic> json) => TimeStudyModel(
        id: json["id"],
        studyTime: json["study_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "study_time": studyTime,
      };
}
