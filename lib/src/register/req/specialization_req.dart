class SpecializationReq {
  SpecializationReq({
    required this.facultyId,
    required this.degeeId,
  });

  int facultyId;
  int degeeId;

  factory SpecializationReq.fromJson(Map<String, dynamic> json) =>
      SpecializationReq(
        facultyId: json["faculty_id"],
        degeeId: json["degee_id"],
      );

  Map<String, dynamic> toJson() => {
        "faculty_id": facultyId,
        "degee_id": degeeId,
      };
}
