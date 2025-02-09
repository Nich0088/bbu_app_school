//import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../common/app_setting.dart';
import '../../../common/widgets/custom_app_bar.dart';
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
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
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
  bool loading = false;
  List<Calendar> _calendarList = [];

  @override
  void initState() {
    loading = true;
    DateTime now = DateTime.now();
    getListEventDay(now.year.toString(), now.month.toString());
    super.initState();

    ///calandar
    bbuFirstDay = DateTime(bbuToday.year, bbuToday.month - 1, bbuToday.day);
    bbuLastDay = DateTime(bbuToday.year, bbuToday.month + 1, bbuToday.day);

    ///new block
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _bbuEventSourceAll[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
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
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: AppColor.textTertiaryColor,
          ),
        ),
      ),
      child: Scaffold(
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
                todayTextStyle: const TextStyle(
                  color: AppColor.textPrimaryColor,
                ),
                markerDecoration: BoxDecoration(
                  border: Border.all(width: 1),
                  shape: BoxShape.circle,
                  color: Colors.redAccent,
                ),
                weekendTextStyle: const TextStyle(color: Colors.blue),
                holidayTextStyle: const TextStyle(color: Colors.red),
                holidayDecoration: BoxDecoration(
                  border: Border.all(width: 5),
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
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
              headerStyle: const HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
              ),
            ),
            const SizedBox(height: 8.0),
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
                      title: Text(
                        "${event1.day}: ${event1.title}",
                        style: const TextStyle(
                          color: Colors.blueAccent,
                          fontFamily: AppFontFamily.khmerFontFamily,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getListEventDay(String year, String month) async {
    CalendarData data = CalendarData();
    var result = await data.getList(year, month);

    setState(() {
      loading = false;
      _selectedEvents.value = [];

      _calendarList = result.calendarList;
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
    });
  }
}
