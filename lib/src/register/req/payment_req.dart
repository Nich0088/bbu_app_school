class PaymentReq {
  PaymentReq({
    required this.bankId,
    this.payDate,
    required this.amount,
    required this.discount,
    required this.note,
    required this.accNumber,
    required this.accName,
    required this.reciept,
    required this.imageQrcode,
    required this.studentId,
  });

  int bankId;
  DateTime? payDate;
  double amount;
  double discount;
  String note;
  String accNumber;
  String accName;
  String reciept;
  String imageQrcode;
  String studentId;

  factory PaymentReq.fromJson(Map<String, dynamic> json) => PaymentReq(
        bankId: json["bank_id"],
        payDate: json["pay_date"],
        amount: json["amount"],
        discount: json["discount"],
        note: json["note"],
        accNumber: json["acc_number"],
        accName: json["acc_name"],
        reciept: json["reciept"],
        imageQrcode: json["image_qrcode"],
        studentId: json["student_id"],
      );

  Map<String, dynamic> toJson() => {
        "bank_id": bankId,
        "pay_date": payDate,
        "amount": amount,
        "discount": discount,
        "note": note,
        "acc_number": accNumber,
        "acc_name": accName,
        "reciept": reciept,
        "image_qrcode": imageQrcode,
        "student_id": studentId,
      };
}
