class PaymentMethodRes {
  PaymentMethodRes({
    required this.code,
    required this.message,
    required this.dataPaymentMethodList,
  });

  int code;
  String message;
  List<DataPaymentMethodList> dataPaymentMethodList;

  factory PaymentMethodRes.fromJson(Map<String, dynamic> json) =>
      PaymentMethodRes(
        code: json["code"],
        message: json["message"],
        dataPaymentMethodList: json["data"] != null
            ? List<DataPaymentMethodList>.from(
                json["data"].map((x) => DataPaymentMethodList.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data":
            List<dynamic>.from(dataPaymentMethodList.map((x) => x.toJson())),
      };
}

class DataPaymentMethodList {
  DataPaymentMethodList({
    required this.discount,
    required this.afterDiscount,
    required this.formatDesc,
    required this.bankList,
  });

  double discount;
  double afterDiscount;
  String formatDesc;
  List<BankList> bankList;

  factory DataPaymentMethodList.fromJson(Map<String, dynamic> json) =>
      DataPaymentMethodList(
        discount: json["discount"],
        afterDiscount: json["after_discount"],
        formatDesc: json["format_desc"],
        bankList: json["bank_list"] != null
            ? List<BankList>.from(
                json["bank_list"].map((x) => BankList.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "discount": discount,
        "after_discount": afterDiscount,
        "format_desc": formatDesc,
        "bank_list": List<dynamic>.from(bankList.map((x) => x.toJson())),
      };
}

class BankList {
  BankList({
    required this.bankId,
    required this.bankName,
    required this.accNumber,
    required this.accName,
    required this.qrcodeImge,
  });

  int bankId;
  String bankName;
  String accNumber;
  String accName;
  String qrcodeImge;

  factory BankList.fromJson(Map<String, dynamic> json) => BankList(
        bankId: json["bank_id"],
        bankName: json["bank_name"],
        accNumber: json["acc_number"],
        accName: json["acc_name"],
        qrcodeImge: json["qrcode_imge"],
      );

  Map<String, dynamic> toJson() => {
        "bank_id": bankId,
        "bank_name": bankName,
        "acc_number": accNumber,
        "acc_name": accName,
        "qrcode_imge": qrcodeImge,
      };
}
