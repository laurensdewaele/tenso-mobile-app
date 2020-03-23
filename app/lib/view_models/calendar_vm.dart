import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:app/models/completed_workout.dart';
import 'package:app/models/completed_workouts.dart';
import 'package:app/state/app_state.dart';
import 'package:app/widgets/calendar/table.dart';

class CalendarViewModel extends ChangeNotifier {
  CalendarViewModel() {
    _selectedDay = DateTime.now();
    _selectedMonth = _selectedDay;
  }

  AppState _appState;
  DateTime _selectedDay;
  DateTime get selectedDay => _selectedDay;
  DateTime _selectedMonth;
  DateTime get selectedMonth => _selectedMonth;
  List<CompletedWorkout> _completedWorkoutsForSelectedDay;
  List<CompletedWorkout> get completedWorkoutsForSelectedDay =>
      _completedWorkoutsForSelectedDay;
  List<CalendarTableDay> _calendarTableDays;
  List<CalendarTableDay> get calendarTableDays => _calendarTableDays;
  List<DateTime> _calendarDatePickerMonths;
  List<DateTime> get calendarDatePickerMonths => _calendarDatePickerMonths;

  void update(AppState appState) {
    if (appState?.completedWorkouts?.completedWorkouts != null) {
      _appState = appState;
      _setCompletedWorkoutsForSelectedDay();
      _setCalendarTableDays();
      _setDatePickerMonths();
      notifyListeners();
    }
  }

  void setSelectedDay(DateTime day) {
    _selectedDay = day;
    _setCompletedWorkoutsForSelectedDay();
    _setCalendarTableDays();
    notifyListeners();
  }

  void setSelectedMonth(DateTime month) {
    _selectedMonth = month;
    _setCompletedWorkoutsForSelectedDay();
    _setCalendarTableDays();
    notifyListeners();
  }

  void setPreviousMonth() {
    final DateTime newMonth =
        DateTime.utc(_selectedMonth.year, _selectedMonth.month - 1);

    if (calendarDatePickerMonths.where((m) => isSameMonth(m, newMonth)).length >
        0) {
      setSelectedMonth(newMonth);
    }
  }

  void setNextMonth() {
    final DateTime newMonth =
        DateTime.utc(_selectedMonth.year, _selectedMonth.month + 1);

    if (calendarDatePickerMonths.where((m) => isSameMonth(m, newMonth)).length >
        0) {
      setSelectedMonth(newMonth);
    }
  }

  void _setCalendarTableDays() {
    _calendarTableDays = _daysInMonth(_selectedMonth)
        .map((DateTime day) => CalendarTableDay(
            day: day,
            belongsToSelectedMonth: isSameMonth(day, _selectedMonth),
            selected: _isSameDay(day, _selectedDay),
            completedWorkoutColors:
                _getCompletedWorkoutColors(day, _appState?.completedWorkouts)))
        .toList();
  }

  void _setCompletedWorkoutsForSelectedDay() {
    _completedWorkoutsForSelectedDay = _appState
        ?.completedWorkouts?.completedWorkouts
        ?.where((completedWorkout) =>
            _isSameDay(completedWorkout.completedDate, _selectedDay))
        ?.toList();
  }

  void _setDatePickerMonths() {
    List<DateTime> completedWorkoutMonths = _appState
        ?.completedWorkouts?.completedWorkouts
        ?.map((completedWorkout) => DateTime.utc(
            completedWorkout.completedDate.year,
            completedWorkout.completedDate.month))
        ?.toList();
    completedWorkoutMonths.sort((DateTime a, DateTime b) => a.compareTo(b));

    DateTime first = completedWorkoutMonths.length > 0
        ? completedWorkoutMonths[0]
        : DateTime.now().toUtc();
    DateTime last = DateTime.now().toUtc();
    DateTime threeBeforeFirst = DateTime(first.year, first.month - 3);
    DateTime threeAfterLast = DateTime(last.year, last.month + 3);

    _calendarDatePickerMonths =
        _monthsInRange(threeBeforeFirst, threeAfterLast).toList();
  }

  void deleteCompletedWorkout(CompletedWorkout completedWorkout) {
    final _workoutList = []
      ..addAll(_appState?.completedWorkouts?.completedWorkouts?.toList());
    _workoutList.removeWhere((c) => c.id == completedWorkout.id);
    _setAndSaveCompletedWorkouts(_appState?.completedWorkouts
        ?.rebuild((b) => b..completedWorkouts.replace(_workoutList)));
  }

  void _setAndSaveCompletedWorkouts(CompletedWorkouts completedWorkouts) {
    _appState?.setCompletedWorkouts(completedWorkouts);
    _appState?.saveCompletedWorkouts(completedWorkouts);
  }
}

List<Color> _getCompletedWorkoutColors(
    DateTime day, CompletedWorkouts completedWorkouts) {
  return completedWorkouts.completedWorkouts
      .where(
          (completedWorkout) => _isSameDay(completedWorkout.completedDate, day))
      .map((completedWorkout) => completedWorkout.workout.difficultyColor)
      .toList();
}

bool _isSameDay(DateTime first, DateTime second) {
  return first.year == second.year &&
      first.month == second.month &&
      first.day == second.day;
}

bool isSameMonth(DateTime first, DateTime second) {
  return first.year == second.year && first.month == second.month;
}

List<DateTime> _daysInMonth(DateTime month) {
  final first = DateTime.utc(month.year, month.month, 1);
  final daysBefore = first.weekday - 1;
  final firstToDisplay = first.subtract(Duration(days: daysBefore));
  final last = DateTime.utc(month.year, month.month + 1, 1)
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

Iterable<DateTime> _monthsInRange(
    DateTime firstMonth, DateTime lastMonth) sync* {
  var temp = firstMonth;

  while (temp.compareTo(lastMonth) < 1) {
    yield _normalizeDate(temp);
    temp = DateTime(temp.year, temp.month + 1);
  }
}

DateTime _normalizeDate(DateTime value) {
  return DateTime.utc(value.year, value.month, value.day, 12);
}
