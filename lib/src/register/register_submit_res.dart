class RegisterSubmitRes {
  String firstName;
  String firstNameKhmer;
  String lastName;
  String lastNameKhmer;
  String sex;
  int selectBirthMonth;
  int selectDay;
  int selectYear;
  String placeOfBirth;
  String photo;
  String phone;
  String? studentTemId;

  RegisterSubmitRes(
      {required this.firstName,
      required this.firstNameKhmer,
      required this.lastName,
      required this.lastNameKhmer,
      required this.sex,
      required this.selectBirthMonth,
      required this.selectDay,
      required this.selectYear,
      required this.placeOfBirth,
      required this.photo,
      required this.phone,
      this.studentTemId});

  factory RegisterSubmitRes.fromJson(Map<String, dynamic> json) =>
      RegisterSubmitRes(
        firstName: json['first_name'],
        firstNameKhmer: json['first_name_khmer'],
        lastName: json['last_name'],
        lastNameKhmer: json['last_name_khmer'],
        sex: json['sex'],
        selectBirthMonth: json['select_birth_month'],
        selectDay: json['select_day'],
        selectYear: json['select_year'],
        placeOfBirth: json['place_of_birth'],
        photo: json['photo'],
        phone: json['phone'],
        studentTemId: json['student_tem_id'],
      );

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'first_name_khmer': firstNameKhmer,
        'last_name': lastName,
        'last_name_khmer': lastNameKhmer,
        'sex': sex,
        'select_birth_month': selectBirthMonth,
        'select_day': selectDay,
        'select_year': selectYear,
        'place_of_birth': placeOfBirth,
        'photo': photo,
        'phone': phone,
        'student_tem_id': studentTemId,
      };
}
