class RegisterSubmitStudyRes {
  int brandId;
  int departmentId;
  int degreeId;
  int facultyId;
  double chooseAcademicPrice;
  int studyTimeId;
  String studentTemId;

  RegisterSubmitStudyRes(
      {required this.brandId,
      required this.departmentId,
      required this.degreeId,
      required this.facultyId,
      required this.chooseAcademicPrice,
      required this.studyTimeId,
      required this.studentTemId});

  factory RegisterSubmitStudyRes.fromJson(Map<String, dynamic> json) =>
      RegisterSubmitStudyRes(
        brandId: json['brand_id'],
        departmentId: json['department_id'],
        degreeId: json['degree_id'],
        facultyId: json['faculty_id'],
        chooseAcademicPrice: json['choose_academic_price'],
        studyTimeId: json['study_time_id'],
        studentTemId: json['student_tem_id'],
      );

  Map<String, dynamic> toJson() => {
        'brand_id': brandId,
        'department_id': departmentId,
        'degree_id': degreeId,
        'faculty_id': facultyId,
        'choose_academic_price': chooseAcademicPrice,
        'study_time_id': studyTimeId,
        'student_tem_id': studentTemId,
      };
}
