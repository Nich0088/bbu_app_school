class PaymentRes {
  int bankId;
  String payDate;
  double amount;
  double discount;
  String? note;
  String accNumber;
  String accName;
  String? reciept;
  String? recieptUrl;
  String imageQrcode;
  String imageQrcodeUrl;
  String studentId;

  PaymentRes(
      {required this.bankId,
      required this.payDate,
      required this.amount,
      required this.discount,
      this.note,
      required this.accNumber,
      required this.accName,
      this.reciept,
      this.recieptUrl,
      required this.imageQrcode,
      required this.imageQrcodeUrl,
      required this.studentId});

  factory PaymentRes.fromJson(Map<String, dynamic> json) => PaymentRes(
        bankId: json['bank_id'],
        payDate: json['pay_date'],
        amount: json['amount'],
        discount: json['discount'],
        note: json['note'],
        accNumber: json['acc_number'],
        accName: json['acc_name'],
        reciept: json['reciept'],
        recieptUrl: json['reciept_url'],
        imageQrcode: json['image_qrcode'],
        imageQrcodeUrl: json['image_qrcode_url'],
        studentId: json['student_id'],
      );

  Map<String, dynamic> toJson() => {
        'bank_id': bankId,
        'pay_date': payDate,
        'amount': amount,
        'discount': discount,
        'note': note,
        'acc_number': accNumber,
        'acc_name': accName,
        'reciept': reciept,
        'reciept_url': recieptUrl,
        'image_qrcode': imageQrcode,
        'image_qrcode_url': imageQrcodeUrl,
        'student_id': studentId,
      };
}
