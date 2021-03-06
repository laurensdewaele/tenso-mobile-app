import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/modules/calendar/calendar_table_day.dart';
import 'package:tenso_app/services/navigation.service.dart';
import 'package:tenso_app/state/completed_workouts.state.dart';
import 'package:tenso_app/state/workouts.state.dart';

class CalendarViewModel extends ChangeNotifier {
  CompletedWorkoutsState _completedWorkoutsState;
  List<CompletedWorkout> _completedWorkoutList;
  WorkoutsState _workoutsState;
  StreamSubscription _sub;

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

  NavigationService _navigationService;

  CalendarViewModel() {
    _navigationService = NavigationService();
    _completedWorkoutsState = CompletedWorkoutsState();
    _completedWorkoutList = _completedWorkoutsState.completedWorkoutList;
    _sub = _completedWorkoutsState.completedWorkoutList$.listen((c) {
      _completedWorkoutList = c;
      _setVariables();
    });
    _workoutsState = WorkoutsState();
    _selectedDay = DateTime.now();
    _selectedMonth = _selectedDay;
    _setVariables();
  }

  void _setVariables() {
    _setCompletedWorkoutsForSelectedDay();
    _setCalendarTableDays();
    _setDatePickerMonths();
    notifyListeners();
  }

  void setSelectedDay(DateTime date) {
    _selectedDay = date;
    _setCompletedWorkoutsForSelectedDay();
    _setCalendarTableDays();
    notifyListeners();
  }

  void setSelectedMonth(DateTime date) {
    _selectedMonth = date;
    _setCompletedWorkoutsForSelectedDay();
    _setCalendarTableDays();
    notifyListeners();
  }

  void setPreviousMonth() {
    final DateTime newMonth =
        DateTime(_selectedMonth.year, _selectedMonth.month - 1);

    if (calendarDatePickerMonths.where((m) => isSameMonth(m, newMonth)).length >
        0) {
      setSelectedMonth(newMonth);
    }
  }

  void setNextMonth() {
    final DateTime newMonth =
        DateTime(_selectedMonth.year, _selectedMonth.month + 1);

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
                _getWorkoutLabelColors(day, _completedWorkoutList)))
        .toList();
  }

  void _setCompletedWorkoutsForSelectedDay() {
    _completedWorkoutsForSelectedDay = _completedWorkoutList
        .where((completedWorkout) =>
            _isSameDay(completedWorkout.completedLocalDate, _selectedDay))
        ?.toList();
  }

  void _setDatePickerMonths() {
    List<DateTime> completedWorkoutMonths = _completedWorkoutList
        .map((completedWorkout) => DateTime(
            completedWorkout.completedLocalDate.year,
            completedWorkout.completedLocalDate.month))
        ?.toList();
    completedWorkoutMonths.sort((DateTime a, DateTime b) => a.compareTo(b));

    DateTime first = completedWorkoutMonths.length > 0
        ? completedWorkoutMonths[0]
        : DateTime.now();
    DateTime last = DateTime.now();
    DateTime threeBeforeFirst = DateTime(first.year, first.month - 3);
    DateTime threeAfterLast = DateTime(last.year, last.month + 3);

    _calendarDatePickerMonths =
        _monthsInRange(threeBeforeFirst, threeAfterLast).toList();
  }

  void deleteCompletedWorkout(CompletedWorkout completedWorkout) {
    _completedWorkoutsState.deleteCompletedWorkout(completedWorkout);
  }

  void copyCompletedWorkout(CompletedWorkout completedWorkout) {
    _workoutsState.copyWorkout(completedWorkout.workout);
    _navigationService.popUntil(ModalRoute.withName('/'));
  }

  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}

List<Color> _getWorkoutLabelColors(
    DateTime day, List<CompletedWorkout> completedWorkoutList) {
  return completedWorkoutList
      .where((completedWorkout) =>
          _isSameDay(completedWorkout.completedLocalDate, day))
      .map((completedWorkout) => completedWorkout.workout.label.color)
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
  final first = DateTime(month.year, month.month, 1);
  final daysBefore = first.weekday - 1;
  final firstToDisplay = first.subtract(Duration(days: daysBefore));
  final last = DateTime(month.year, month.month + 1, 1)
      .subtract(const Duration(days: 1));
  final daysAfter = 7 - last.weekday;
  final lastToDisplay = last.add(Duration(days: daysAfter));
  return _daysInRange(firstToDisplay, lastToDisplay).toList();
}

Iterable<DateTime> _daysInRange(DateTime firstDay, DateTime lastDay) sync* {
  var temp = firstDay.toUtc();

  while (temp.compareTo(lastDay.toUtc()) < 1) {
    yield temp;
    temp = temp.add(const Duration(days: 1));
  }
}

Iterable<DateTime> _monthsInRange(
    DateTime firstMonth, DateTime lastMonth) sync* {
  var temp = firstMonth;

  while (temp.compareTo(lastMonth) < 1) {
    yield temp;
    temp = DateTime(temp.year, temp.month + 1);
  }
}
