import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

class CheckInController extends GetxController {
  @factoryMethod
  static init() => Get.put(CheckInController());

  List<AttendantItem> checkInList = [
    // AttendantItem(
    //   id: 1,
    //   subjectName: "Math",
    //   date: "2023-10-01",
    //   time: "09:00",
    //   isCheckIn: true,
    // ),
    AttendantItem(
      id: 2,
      subjectName: "Physics",
      date: "15/12/2024",
      time: "8:30",
      isCheckIn: false,
    ),
    AttendantItem(
      id: 3,
      subjectName: "Chemistry",
      date: "15/12/2024",
      time: "5:30",
      isCheckIn: true,
    ),
    // AttendantItem(
    //   id: 4,
    //   subjectName: "Biology",
    //   date: "2023-10-04",
    //   time: "12:00",
    //   isCheckIn: false,
    // ),
    // AttendantItem(
    //   id: 5,
    //   subjectName: "English",
    //   date: "2023-10-05",
    //   time: "13:00",
    //   isCheckIn: true,
    // ),
    // AttendantItem(
    //   id: 6,
    //   subjectName: "History",
    //   date: "2023-10-06",
    //   time: "14:00",
    //   isCheckIn: true,
    // ),
    // AttendantItem(
    //   id: 7,
    //   subjectName: "Geography",
    //   date: "2023-10-07",
    //   time: "15:00",
    //   isCheckIn: false,
    // ),
    // AttendantItem(
    //   id: 8,
    //   subjectName: "Art",
    //   date: "2023-10-08",
    //   time: "16:00",
    //   isCheckIn: true,
    // ),
    // AttendantItem(
    //   id: 9,
    //   subjectName: "Physical Education",
    //   date: "2023-10-09",
    //   time: "17:00",
    //   isCheckIn: false,
    // ),
    // AttendantItem(
    //   id: 10,
    //   subjectName: "Computer Science",
    //   date: "2023-10-10",
    //   time: "18:00",
    //   isCheckIn: true,
    // ),
  ];
}

class AttendantItem {
  final int id;
  final String subjectName;
  final String date;
  final String time;
  final bool isCheckIn;

  AttendantItem({
    required this.id,
    required this.subjectName,
    required this.date,
    required this.time,
    required this.isCheckIn,
  });
}
