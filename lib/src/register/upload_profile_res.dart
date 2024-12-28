class UploadProfileRes {
  String photoName;

  UploadProfileRes({required this.photoName});

  factory UploadProfileRes.fromJson(Map<String, dynamic> json) =>
      UploadProfileRes(photoName: json['photo_name']);

  Map<String, dynamic> toJson() => {'photo_name': photoName};
}
