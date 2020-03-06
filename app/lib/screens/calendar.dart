import 'package:app/widgets/button.dart';
import 'package:flutter/cupertino.dart' hide Icon;
import 'package:intl/intl.dart' show DateFormat;

import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;

import 'package:app/data/completed_workout.dart';
import 'package:app/models/completed_workout.dart';
import 'package:app/models/completed_workouts.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/card.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/top_navigation.dart';

// TODO: Screen and KeyboardScreen should be refactored
class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDate = DateTime.now();
  DateTime _targetDateTime = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  EventList<_CompletedWorkoutEvent> _eventList =
      _generateEventList(completedWorkouts);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
        gradientStartColor: styles.Colors.bgGrayStart,
        gradientStopColor: styles.Colors.bgGrayStop,
        child: ListView(physics: ClampingScrollPhysics(), children: [
          Column(
            children: <Widget>[
              TopNavigation(
                title: 'calendar',
                dark: true,
              ),
              Divider(height: styles.Measurements.xxl),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: styles.Measurements.xs),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: styles.Measurements.m,
                        vertical: styles.Measurements.l),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _currentMonth,
                          style: styles.Staatliches.xlBlack,
                        ),
                        Divider(height: styles.Measurements.l),
                        Container(
                          height: 500,
                          width: double.infinity,
                          child: CalendarCarousel<_CompletedWorkoutEvent>(
                            selectedDateTime: _selectedDate,
                            targetDateTime: _targetDateTime,
                            minSelectedDate: _selectedDate
                                .subtract(Duration(days: 360 * 100)),
                            maxSelectedDate:
                                _selectedDate.add(Duration(days: 360 * 100)),
                            markedDatesMap: _eventList,

                            // Needs material in order to show the header
                            showHeader: false,

                            firstDayOfWeek: 1,
                            customWeekDayBuilder: _customWeekDayBuilder,
                            weekdayTextStyle: styles.Lato.xsBlack,

                            prevDaysTextStyle: styles.Staatliches.xsLightGray,
                            nextDaysTextStyle: styles.Staatliches.xsLightGray,
                            inactiveDaysTextStyle:
                                styles.Staatliches.xsLightGray,

                            daysTextStyle: styles.Staatliches.xsBlack,
                            weekendTextStyle: styles.Staatliches.xsBlack,
                            todayTextStyle: styles.Staatliches.xsBlack,
                            selectedDayTextStyle: styles.Staatliches.xsWhite,

                            onDayPressed: (DateTime date,
                                List<_CompletedWorkoutEvent> events) {
                              this.setState(() => _selectedDate = date);
                            },
                            onDayLongPressed: (_) {},
                            onCalendarChanged: (DateTime date) {
                              print('on calendar changed, $date');
                              setState(() {
                                _targetDateTime = date;
                                _currentMonth = DateFormat.yMMM().format(date);
                              });
                            },

                            isScrollable: true,
                            customGridViewPhysics:
                                NeverScrollableScrollPhysics(),
                          ),
                        ),
                        Divider(height: styles.Measurements.xxl),
                        Button(
                          text: 'jump next month',
                          handleTap: () {
                            setState(() {
                              // TODO: We can only jump one month, otherwise the animation freaks.
                              _targetDateTime = DateTime(2020, 7, 30);
//                              _targetDateTime = DateTime(_targetDateTime.year,
//                                  _targetDateTime.month + 1);
                              _currentMonth =
                                  DateFormat.yMMM().format(_targetDateTime);
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ]));
  }
}

Widget _customWeekDayBuilder(int weekday, String weekdayName) {
  Text text;

  switch (weekday) {
    case 0:
      text = Text(
        'mo',
        style: styles.Lato.xsBlack,
      );
      break;
    case 1:
      text = Text(
        'tu',
        style: styles.Lato.xsBlack,
      );
      break;
    case 2:
      text = Text(
        'we',
        style: styles.Lato.xsBlack,
      );
      break;
    case 3:
      text = Text(
        'th',
        style: styles.Lato.xsBlack,
      );
      break;
    case 4:
      text = Text(
        'fr',
        style: styles.Lato.xsBlack,
      );
      break;
    case 5:
      text = Text(
        'sa',
        style: styles.Lato.xsBlack,
      );
      break;
    case 6:
      text = Text(
        'su',
        style: styles.Lato.xsBlack,
      );
      break;
  }

  return Expanded(
    child: Container(
      height: styles.Measurements.xl,
      child: Center(
        child: text,
      ),
    ),
  );
}

class _CompletedWorkoutEvent extends EventInterface {
  final CompletedWorkout completedWorkout;
  final DateTime date;

  _CompletedWorkoutEvent({
    @required this.completedWorkout,
    @required this.date,
  }) : assert(date != null);

  @override
  bool operator ==(dynamic other) {
    return this.date == other.date &&
        this.completedWorkout == other.completedWorkout;
  }

  @override
  int get hashCode => hashValues(completedWorkout, date);

  @override
  DateTime getDate() {
    return date;
  }

  @override
  Widget getDot() {
    return null;
  }

  @override
  Widget getIcon() {
    return null;
  }

  @override
  String getTitle() {
    return null;
  }
}

EventList<_CompletedWorkoutEvent> _generateEventList(
    CompletedWorkouts completedWorkouts) {
  final List<DateTime> dates = completedWorkouts.completedWorkouts
      .map((CompletedWorkout completedWorkout) => completedWorkout.date)
      .toList();
  // Remove duplicates
  final List<DateTime> uniqueDates = dates.toSet().toList();
  final Map<DateTime, List<_CompletedWorkoutEvent>> completedWorkoutsAsMap =
      uniqueDates.asMap().map((int key, DateTime date) => MapEntry(
          date,
          completedWorkouts.completedWorkouts
              .where((CompletedWorkout completedWorkout) =>
                  completedWorkout.date == date)
              .map((CompletedWorkout completedWorkout) =>
                  _CompletedWorkoutEvent(
                      completedWorkout: completedWorkout,
                      date: completedWorkout.date))
              .toList()));
  return EventList<_CompletedWorkoutEvent>(events: completedWorkoutsAsMap);
}
