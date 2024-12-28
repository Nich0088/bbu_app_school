class StudentInfoPayRes {
  StudentInfoPayRes({
    required this.code,
    required this.message,
    required this.studentInfo,
    required this.studentPayinfo,
  });

  int code;
  String message;
  DataStudentInfo studentInfo;
  StudentPayinfo? studentPayinfo;

  factory StudentInfoPayRes.fromJson(Map<String, dynamic> json) =>
      StudentInfoPayRes(
        code: json["code"],
        message: json["message"],
        studentInfo: DataStudentInfo.fromJson(json["data"]),
        studentPayinfo: json["studpay"] == null
            ? null
            : StudentPayinfo.fromJson(json["studpay"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": studentInfo.toJson(),
        "studpay": studentPayinfo!.toJson(),
      };
}

class DataStudentInfo {
  DataStudentInfo({
    this.studentId,
    required this.studentIdTemp,
    required this.studentNameEn,
    required this.studentNameKh,
    required this.firstNameEn,
    required this.firstNameKh,
    required this.lastNameEn,
    required this.lastNameKh,
    required this.sex,
    required this.dateOfBirth,
    required this.placeOfBirth,
    required this.photo,
    required this.photoUrl,
    required this.phone,
    required this.branchNameEn,
    required this.branchNameKh,
    required this.specializationEn,
    required this.specializationKh,
    required this.degreeEn,
    required this.degreeKh,
    required this.facultyEn,
    required this.facultyKh,
    required this.chooseAcademicPrice,
    required this.studyTime,
    this.password,
    this.stutusStudent,
  });

  String? studentId;
  String studentIdTemp;
  String studentNameEn;
  String studentNameKh;
  String firstNameEn;
  String firstNameKh;
  String lastNameEn;
  String lastNameKh;
  String sex;
  DateTime dateOfBirth;
  String placeOfBirth;
  String? photo;
  String? photoUrl;
  String phone;
  String branchNameEn;
  String branchNameKh;
  String specializationEn;
  String specializationKh;
  String degreeEn;
  String degreeKh;
  String facultyEn;
  String facultyKh;
  double chooseAcademicPrice;
  String studyTime;
  String? password;
  String? stutusStudent;

  factory DataStudentInfo.fromJson(Map<String, dynamic> json) =>
      DataStudentInfo(
        studentId: json["student_id"],
        studentIdTemp: json["student_id_temp"],
        studentNameEn: json["student_name_en"],
        studentNameKh: json["student_name_kh"],
        firstNameEn: json["first_name_en"],
        firstNameKh: json["first_name_kh"],
        lastNameEn: json["last_name_en"],
        lastNameKh: json["last_name_kh"],
        sex: json["sex"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        placeOfBirth: json["place_of_birth"],
        photo: json["photo"],
        photoUrl: json["photo_url"],
        phone: json["phone"],
        branchNameEn: json["branch_name_en"],
        branchNameKh: json["branch_name_kh"],
        specializationEn: json["specialization_en"],
        specializationKh: json["specialization_kh"],
        degreeEn: json["degree_en"],
        degreeKh: json["degree_kh"],
        facultyEn: json["faculty_en"],
        facultyKh: json["faculty_kh"],
        chooseAcademicPrice: json["choose_academic_price"],
        studyTime: json["study_time"],
        password: json["password"],
        stutusStudent: json["stutus_student"],
      );

  Map<String, dynamic> toJson() => {
        "student_id": studentId,
        "student_id_temp": studentIdTemp,
        "student_name_en": studentNameEn,
        "student_name_kh": studentNameKh,
        "first_name_en": firstNameEn,
        "first_name_kh": firstNameKh,
        "last_name_en": lastNameEn,
        "last_name_kh": lastNameKh,
        "sex": sex,
        "date_of_birth": dateOfBirth.toIso8601String(),
        "place_of_birth": placeOfBirth,
        "photo": photo,
        "photo_url": photoUrl,
        "phone": phone,
        "branch_name_en": branchNameEn,
        "branch_name_kh": branchNameKh,
        "specialization_en": specializationEn,
        "specialization_kh": specializationKh,
        "degree_en": degreeEn,
        "degree_kh": degreeKh,
        "faculty_en": facultyEn,
        "faculty_kh": facultyKh,
        "choose_academic_price": chooseAcademicPrice,
        "study_time": studyTime,
        "password": password,
        "stutus_student": stutusStudent,
      };
}

class StudentPayinfo {
  StudentPayinfo({
    required this.paymenTStudentId,
    required this.paymenTGatewaYs,
    required this.studenTId,
    required this.paYDate,
    this.reciept,
    required this.amount,
    required this.discount,
    this.note,
    this.status,
  });

  int paymenTStudentId;
  String paymenTGatewaYs;
  String studenTId;
  DateTime paYDate;
  String? reciept;
  double amount;
  double discount;
  String? note;
  String? status;

  factory StudentPayinfo.fromJson(Map<String, dynamic> json) => StudentPayinfo(
        paymenTStudentId: json["paymenT_STUDENT_ID"],
        paymenTGatewaYs: json["paymenT_GATEWAYs"],
        studenTId: json["studenT_ID"],
        paYDate: DateTime.parse(json["paY_DATE"]),
        reciept: json["reciept"],
        amount: json["amount"],
        discount: json["discount"],
        note: json["note"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "paymenT_STUDENT_ID": paymenTStudentId,
        "paymenT_GATEWAYs": paymenTGatewaYs,
        "studenT_ID": studenTId,
        "paY_DATE": paYDate.toIso8601String(),
        "reciept": reciept,
        "amount": amount,
        "discount": discount,
        "note": note,
        "status": status,
      };
}
