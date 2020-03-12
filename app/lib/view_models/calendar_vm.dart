import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:app/models/completed_workout.dart';
import 'package:app/models/completed_workouts.dart';
import 'package:app/widgets/calendar/date_picker.dart';
import 'package:app/widgets/calendar/table.dart';

class CalendarViewModel extends ChangeNotifier {
  CalendarViewModel({CompletedWorkouts completedWorkouts}) {
    _completedWorkouts = completedWorkouts;
    _initialize();
  }

  CompletedWorkouts _completedWorkouts;
  DateTime _selectedDay;
  DateTime get selectedDay => _selectedDay;
  DateTime _selectedMonth;
  DateTime get selectedMonth => _selectedMonth;
  List<CompletedWorkout> _completedWorkoutsForSelectedDay;
  List<CompletedWorkout> get completedWorkoutsForSelectedDay =>
      _completedWorkoutsForSelectedDay;
  List<CalendarTableDay> _calendarTableDays;
  List<CalendarTableDay> get calendarTableDays => _calendarTableDays;
  List<CalendarDatePickerMonth> get datePickerMonths => _getDatePickerMonths();

  void _initialize() {
    _selectedDay = DateTime.now();
    _selectedMonth = _selectedDay;
    _setCompletedWorkoutsForSelectedDay();
    _setCalendarTableDays();
    notifyListeners();
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
    if (_selectedMonth.month == 1) {
      _selectedMonth = DateTime.utc(_selectedMonth.year - 1, 12);
    } else {
      _selectedMonth =
          DateTime.utc(_selectedMonth.year, _selectedMonth.month - 1);
    }
    _setCalendarTableDays();
    notifyListeners();
  }

  void setNextMonth() {
    if (_selectedMonth.month == 12) {
      _selectedMonth = DateTime.utc(_selectedMonth.year + 1, 1);
    } else {
      _selectedMonth =
          DateTime.utc(_selectedMonth.year, _selectedMonth.month + 1);
    }
    _setCalendarTableDays();
    notifyListeners();
  }

  void _setCalendarTableDays() {
    _calendarTableDays = _daysInMonth(_selectedMonth)
        .map((DateTime day) => CalendarTableDay(
            day: day,
            belongsToSelectedMonth: _isSameMonth(day, _selectedMonth),
            selected: _isSameDay(day, _selectedDay),
            completedWorkoutColors:
                _getCompletedWorkoutColors(day, _completedWorkouts)))
        .toList();
  }

  void _setCompletedWorkoutsForSelectedDay() {
    _completedWorkoutsForSelectedDay = _completedWorkouts.completedWorkouts
        .where((completedWorkout) =>
            _isSameDay(completedWorkout.completedDate, _selectedDay))
        .toList();
  }

  List<CalendarDatePickerMonth> _getDatePickerMonths() {
    List<DateTime> completedWorkoutDates = _completedWorkouts.completedWorkouts
        .map((completedWorkout) => completedWorkout.completedDate);
    completedWorkoutDates.sort((DateTime a, DateTime b) => a.compareTo(b));
    DateTime first = completedWorkoutDates[0];
    DateTime last = completedWorkoutDates[completedWorkoutDates.length - 1];

    List<DateTime> threeBeforeFirst;
    List<DateTime> threeAfterLast;

    for (var i = 1; i < 4; i++) {
      if (first.month - i > 0) {
        threeBeforeFirst.add(DateTime(first.year, first.month - i));
      } else {
        threeBeforeFirst.add(DateTime(first.year - 1, 12 - i + 1));
      }

      if (last.month + i > 12) {
        threeAfterLast.add(DateTime(last.year + 1, i));
      } else {
        threeAfterLast.add(DateTime(last.year, last.month + i));
      }
    }

    List<DateTime> addedMonths = [...threeBeforeFirst, ...threeAfterLast];

    List<CalendarDatePickerMonth> datePickerMonths = completedWorkoutDates.map(
        (DateTime completedWorkoutDate) => CalendarDatePickerMonth(
            date: completedWorkoutDate,
            hasCompletedWorkouts: true,
            isSelectedMonth:
                _isSameMonth(completedWorkoutDate, _selectedMonth)));

    datePickerMonths.addAll(addedMonths.map(
        (DateTime monthWithoutWorkoutDate) => CalendarDatePickerMonth(
            date: monthWithoutWorkoutDate,
            isSelectedMonth:
                _isSameMonth(monthWithoutWorkoutDate, _selectedMonth),
            hasCompletedWorkouts: false)));

    datePickerMonths.sort(
        (CalendarDatePickerMonth a, CalendarDatePickerMonth b) =>
            a.date.compareTo(b.date));
    return datePickerMonths;
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

bool _isSameMonth(DateTime first, DateTime second) {
  return first.year == second.year && first.month == second.month;
}

List<DateTime> _daysInMonth(DateTime month) {
  final first = DateTime.utc(month.year, month.month, 1, 12);
  final daysBefore = first.weekday - 1;
  final firstToDisplay = first.subtract(Duration(days: daysBefore));

  final last = month.month < 12
      ? DateTime.utc(month.year, month.month + 1, 1, 12)
      : DateTime.utc(month.year + 1, 1, 1, 12)
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
