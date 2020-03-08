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
  List<CompletedWorkout> completedWorkoutsForSelectedMonth;

  void _initialize() {
    selectedDay = DateTime.now();
    selectedMonth = selectedDay;
    _setCompletedWorkoutsForSelectedDay();
    _setCompletedWorkoutsForSelectedMonth();
    notifyListeners();
  }

  void _setCompletedWorkoutsForSelectedDay() {
    completedWorkoutsForSelectedDay = completedWorkouts.completedWorkouts
        .where((completedWorkout) =>
            _isSameDay(completedWorkout.date, selectedDay))
        .toList();
  }

  void _setCompletedWorkoutsForSelectedMonth() {
    completedWorkoutsForSelectedMonth = completedWorkouts.completedWorkouts
        .where((completedWorkout) =>
            _isSameMonth(completedWorkout.date, selectedMonth))
        .toList();
  }
}

bool _isSameDay(DateTime first, DateTime second) {
  return first.year == second.year &&
      first.month == second.month &&
      first.day == second.day;
}

bool _isSameMonth(DateTime first, DateTime second) {
  return first.year == second.year && first.month == second.month;
}
