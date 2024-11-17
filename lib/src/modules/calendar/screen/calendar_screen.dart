//import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../constants/app_setting.dart';
import '../controller/calendar_data.dart';
import '../model/calendar_model_res.dart';
import 'calendar_untils.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State createState() => _NewCalendarScreenState();
}

class _NewCalendarScreenState extends State<CalendarScreen>
    with TickerProviderStateMixin {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  //write
  Map<DateTime, List<Event>> _bbuEventSourceAll = {};
  final bbuToday = DateTime.now();
  DateTime bbuFirstDay = DateTime.now();
  DateTime bbuLastDay = DateTime.now();
  int durationInt = 1;
  bool nextPreviese = false;

  //Map<DateTime, List> _events={};
  // //List<DateTime, String> listEvent;
  bool loading = false;

  // //CalendarController _calendarController;
  // late Map<DateTime, List> holidays;
  List<Calendar> _calendarList = [];

  //Map<DateTime, List> _holidays={};
  // Map<DateTime, List<Calendar>> _calendarListAllEvent={};
  //late final ValueNotifier<List<Calendar>> _selectedEventCalandar;
  @override
  void initState() {
    loading = true;
    DateTime now = DateTime.now();
    getListEventDay(now.year.toString(), now.month.toString());

    super.initState();
    // _events = {};
    // //_calendarController = CalendarController();

    // // _animationController = AnimationController(
    // //   value: this,
    // //   duration: const Duration(milliseconds: 400),
    // // );
    // // _animationController.forward();
    ///calandar
    bbuFirstDay = DateTime(bbuToday.year, bbuToday.month - 1, bbuToday.day);
    bbuLastDay = DateTime(bbuToday.year, bbuToday.month + 1, bbuToday.day);
    /////////

    ///new block
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    //_selectedEventCalandar = ValueNotifier(_getEventsForDay(_selectedDay!));
    //end new block
    ////event first loading ======
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

////new calandar

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    //return kEvents[day] ?? [];

    //var dateParse = DateTime.parse(date);
    //getListEventDay("${day.year}", '${day.month}');
    return _bbuEventSourceAll[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    //getListEventDay("${selectedDay.year}", '${selectedDay.month}');
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
        nextPreviese = false;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  void changeDurationMonth(DateTime dateTime) {
    getListEventDay("${dateTime.year}", '${dateTime.month}');
    setState(() {
      _selectedDay == dateTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: CustomAppBar(
        context,
        backgroundColor: AppColor.primaryColor,
        isDashboardAppBar: false,
        title: "Calendar",
        isCenterTitle: true,
        onPressedBack: () {
          context.pop();
        },
      ),
      body: Column(
        children: [
          TableCalendar<Event>(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              //outsideDaysVisible: false,
              todayTextStyle: const TextStyle(
                color: Colors.red,
              ),
              markerDecoration: BoxDecoration(
                  border: Border.all(width: 1),
                  shape: BoxShape.circle,
                  color: Colors.redAccent),
              // outsideDecoration: BoxDecoration(
              //     border: Border.all(width: 1),
              //     shape: BoxShape.circle,
              //     color: Colors.redAccent),
              weekendTextStyle: const TextStyle(color: Colors.blue),
              holidayTextStyle: const TextStyle(color: Colors.red),
              holidayDecoration: BoxDecoration(
                  border: Border.all(width: 5),
                  shape: BoxShape.circle,
                  color: Colors.red),
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
              changeDurationMonth(focusedDay);
              setState(() {
                nextPreviese = true;
              });
            },

            // daysOfWeekStyle: DaysOfWeekStyle(
            //   weekendStyle: const TextStyle().copyWith(color: Colors.blue[600]),
            // ),
            headerStyle: const HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
            ),
          ),
          const SizedBox(height: 8.0),

          // ignore: unnecessary_null_comparison
          //nextPreviese==false?
          // Expanded(
          //   child: ValueListenableBuilder<List<Event>>(
          //     valueListenable: _selectedEvents,
          //     builder: (context, value, _) {
          //       return ListView.builder(
          //         itemCount: value.length,
          //         itemBuilder: (context, index) {
          //           return Container(
          //             margin: const EdgeInsets.symmetric(
          //               horizontal: 12.0,
          //               vertical: 4.0,
          //             ),
          //             decoration: BoxDecoration(
          //               border: Border.all(),
          //               borderRadius: BorderRadius.circular(12.0),
          //             ),
          //             child: ListTile(
          //               onTap: () {
          //                 if (kDebugMode) {
          //                   print('${value[index]}');
          //                 }
          //               },
          //               title: Text('${value[index]}',style: const TextStyle(color: Colors.blueAccent),),
          //             ),
          //           );
          //         },
          //       );
          //     },
          //   ),
          // ),
          // :
          Expanded(
            child: ListView.builder(
              itemCount: _calendarList.length,
              itemBuilder: (context, index) {
                var event1 = _calendarList[index];
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    // onTap: () {
                    //   if (kDebugMode) {
                    //     print(_calendarList[index].title);
                    //   }
                    // },
                    title: Text(
                      "${event1.day}: ${event1.title}",
                      style: const TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  ///end new calandar

//   void _onDaySelected(DateTime? day, List? events, List? holidays) {
//     if (kDebugMode) {
//       print('CALLBACK: _onDaySelected' '$day');
//     }
//      setState(() {
//     });
//   }

  void getListEventDay(String year, String month) async {
    CalendarData data = CalendarData();
    var result = await data.getList(year, month);

    setState(() {
      loading = false;
      //_calendarList=[];
      _selectedEvents.value = [];

      _calendarList = result.calendarList;
      // _holidays={};
      //   _events={};
      // for (var element in _calendarList) {

      //   for (int i = 0; i <= element.endDate.difference(element.startDate).inDays; i++) {
      //      var datetime1=   element.startDate.add(Duration(days: i));
      //       _events[datetime1]=[element.title];
      //       _holidays[datetime1]=[element.title];
      //       //

      //   }
      // }
      //     ///////new =====
      //     ////
      _bbuEventSourceAll = {};
      _bbuEventSourceAll = {
        for (var item in List.generate(_calendarList.length, (index) => index))
          DateTime.utc(
                  _calendarList[item].startDate.year,
                  _calendarList[item].startDate.month,
                  _calendarList[item].startDate.day):
              List.generate(1, (index) => Event(_calendarList[item].title))
      }..addAll({
          bbuToday: [
            const Event('Today\'s Event 1'),
          ],
        });

      ///
      ///
      ///====
    });
  }
}
