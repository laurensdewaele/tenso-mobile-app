import 'package:flutter/cupertino.dart';

import 'package:app/models/completed_workout.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/calendar/constants.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/workout_overview/workout_overview_stack.dart';

class CompletedWorkoutsOverview extends StatelessWidget {
  CompletedWorkoutsOverview(
      {Key key,
      @required this.selectedDay,
      @required this.completedWorkoutsForSelectedDay,
      @required this.handleDeleteTap})
      : super(key: key);

  final DateTime selectedDay;
  final List<CompletedWorkout> completedWorkoutsForSelectedDay;
  final Function(CompletedWorkout completedWorkout) handleDeleteTap;

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
          ...completedWorkoutsForSelectedDay
              .asMap()
              .map((int i, completedWorkout) => MapEntry(
                  i,
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: styles.Colors.black),
                            borderRadius: styles.kBorderRadiusAll),
                        child: WorkoutOverviewStack(
                          completedWorkout: completedWorkout,
                          handleCompletedWorkoutDeleteTap: handleDeleteTap,
                        ),
                      ),
                      if (i < completedWorkoutsForSelectedDay.length - 1)
                        Divider(
                          height: styles.Measurements.m,
                        )
                    ],
                  )))
              .values
              .toList(),
          if (completedWorkoutsForSelectedDay.length == 0)
            Text('There are no completed workouts for this day.',
                style: styles.Lato.sBlack)
        ],
      ),
    );
  }
}