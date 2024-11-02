class CalendarRes {
  CalendarRes({
    required this.calendarList,
  });

  List<Calendar> calendarList;

  factory CalendarRes.fromJson(Map<String, dynamic> json) => CalendarRes(
        calendarList: List<Calendar>.from(
            json["calendar"].map((x) => Calendar.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "calendar": List<dynamic>.from(calendarList.map((x) => x.toJson())),
      };
}

class Calendar {
  Calendar({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.day,
  });

  String title;
  DateTime startDate;
  DateTime endDate;
  String day;

  factory Calendar.fromJson(Map<String, dynamic> json) => Calendar(
        title: json["title"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        day: json["day"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "day": day,
      };
}
