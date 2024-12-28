// class BankList {
//   int bankId;
//   String bankName;
//   String accNumber;
//   String accName;
//   String qrcodeImge;

//   BankList(
//       {this.bankId,
//         this.bankName,
//         this.accNumber,
//         this.accName,
//         this.qrcodeImge});

//   BankList.fromJson(Map<String, dynamic> json) {
//     bankId = json['bank_id'];
//     bankName = json['bank_name'];
//     accNumber = json['acc_number'];
//     accName = json['acc_name'];
//     qrcodeImge = json['qrcode_imge'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['bank_id'] = this.bankId;
//     data['bank_name'] = this.bankName;
//     data['acc_number'] = this.accNumber;
//     data['acc_name'] = this.accName;
//     data['qrcode_imge'] = this.qrcodeImge;
//     return data;
//   }
// }