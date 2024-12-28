class StudentPhonePinConRes {
  StudentPhonePinConRes({
    required this.code,
    required this.message,
    required this.studenttemid,
  });

  int code;
  String message;
  String studenttemid;

  factory StudentPhonePinConRes.fromJson(Map<String, dynamic> json) =>
      StudentPhonePinConRes(
        code: json["code"],
        message: json["message"],
        studenttemid: json["studenttemid"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "studenttemid": studenttemid,
      };
}
