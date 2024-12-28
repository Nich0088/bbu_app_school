class StudentPhonePinConReq {
  StudentPhonePinConReq({
    required this.phone,
    required this.pincode,
  });

  String phone;
  String pincode;

  factory StudentPhonePinConReq.fromJson(Map<String, dynamic> json) =>
      StudentPhonePinConReq(
        phone: json["phone"],
        pincode: json["pincode"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "pincode": pincode,
      };
}
