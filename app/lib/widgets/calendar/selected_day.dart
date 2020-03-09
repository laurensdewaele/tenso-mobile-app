import 'package:flutter/cupertino.dart';

import 'package:app/models/completed_workout.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/calendar/constants.dart';
import 'package:app/widgets/divider.dart';

class CalendarSelectedDay extends StatelessWidget {
  CalendarSelectedDay(
      {Key key, this.selectedDay, this.completedWorkoutsForSelectedDay})
      : super(key: key);

  final DateTime selectedDay;
  final List<CompletedWorkout> completedWorkoutsForSelectedDay;

  @override
  Widget build(BuildContext context) {
    final String weekDay = kWeekDays[selectedDay.weekday];
    final String day = selectedDay.day.toString();
    final String month = kMonths[selectedDay.month];

    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(height: styles.Measurements.xxl),
          Text(
            '$weekDay $day $month',
            style: styles.Staatliches.xlBlack,
          ),
          Divider(
            height: styles.Measurements.l,
          ),
        ],
      ),
    );
  }
}
