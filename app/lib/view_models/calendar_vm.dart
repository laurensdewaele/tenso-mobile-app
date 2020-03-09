import 'package:app/widgets/calendar/table.dart';
import 'package:flutter/material.dart';

import 'package:app/models/completed_workout.dart';
import 'package:app/models/completed_workouts.dart';

class CalendarViewModel extends ChangeNotifier {
  CalendarViewModel({this.completedWorkouts}) {
    _initialize();
  }

  final CompletedWorkouts completedWorkouts;
  DateTime selectedDay;
  DateTime selectedMonth;
  List<CompletedWorkout> completedWorkoutsForSelectedDay;
  List<CalendarTableDay> get calendarTableDays => _getCalendarTableDays();

  void setSelectedDay(DateTime day) {
    selectedDay = day;
    _setCompletedWorkoutsForSelectedDay();
    notifyListeners();
  }

  void _initialize() {
    selectedDay = DateTime.now();
    selectedMonth = selectedDay;
    _setCompletedWorkoutsForSelectedDay();
    notifyListeners();
  }

  List<CalendarTableDay> _getCalendarTableDays() {
    return _daysInMonth(selectedMonth)
        .map((DateTime day) => CalendarTableDay(
            day: day.day,
            belongsToSelectedMonth: day.month == selectedMonth.month,
            selected: day.day == selectedDay.day,
            completedWorkoutColors:
                _getCompletedWorkoutColors(day, completedWorkouts)))
        .toList();
  }

  void _setCompletedWorkoutsForSelectedDay() {
    completedWorkoutsForSelectedDay = completedWorkouts.completedWorkouts
        .where((completedWorkout) =>
            _isSameDay(completedWorkout.date, selectedDay))
        .toList();
  }
}

List<Color> _getCompletedWorkoutColors(
    DateTime day, CompletedWorkouts completedWorkouts) {
  return completedWorkouts.completedWorkouts
      .where((completedWorkout) => _isSameDay(completedWorkout.date, day))
      .map((completedWorkout) => completedWorkout.workout.difficultyColor)
      .toList();
}

bool _isSameDay(DateTime first, DateTime second) {
  return first.year == second.year &&
      first.month == second.month &&
      first.day == second.day;
}

List<DateTime> _daysInMonth(DateTime month) {
  final first = DateTime.utc(month.year, month.month, 1, 12);
  final daysBefore = first.weekday - 1;
  final firstToDisplay = first.subtract(Duration(days: daysBefore));

  final last =
      DateTime.utc(month.year, month.month < 12 ? month.month + 1 : 1, 1, 12)
          .subtract(const Duration(days: 1));
  final daysAfter = 7 - last.weekday;
  final lastToDisplay = last.add(Duration(days: daysAfter));
  return _daysInRange(firstToDisplay, lastToDisplay).toList();
}

Iterable<DateTime> _daysInRange(DateTime firstDay, DateTime lastDay) sync* {
  var temp = firstDay;

  while (temp.compareTo(lastDay) < 1) {
    yield _normalizeDate(temp);
    temp = temp.add(const Duration(days: 1));
  }
}

DateTime _normalizeDate(DateTime value) {
  return DateTime.utc(value.year, value.month, value.day, 12);
}
