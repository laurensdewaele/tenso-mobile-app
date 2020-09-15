import 'package:flutter/cupertino.dart';
import 'package:tenso_app/helpers/nullable.dart';
import 'package:tenso_app/models/completed_workout.model.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/routes/routes.dart';
import 'package:tenso_app/screens/filter.screen.dart';
import 'package:tenso_app/services/navigation.service.dart';
import 'package:tenso_app/state/completed_workouts.state.dart';
import 'package:tenso_app/view_models/stats/total_hang_rest_time_state.vm.dart';
import 'package:tenso_app/widgets/stats/total_hang_rest_time/total_hang_rest_time_chart.dart';

class TotalHangRestTimeViewModel extends ChangeNotifier {
  NavigationService _navigationService;

  TotalHangRestTimeViewModelState _state;
  TotalHangRestTimeViewModelState get state => _state;

  List<TotalHangRestTimeData> _totalHangData;
  List<TotalHangRestTimeData> _totalRestData;

  List<TotalHangRestTimeData> _filteredHangData;
  List<TotalHangRestTimeData> _filteredRestData;

  TotalHangRestTimeViewModel() {
    _navigationService = NavigationService();

    final List<CompletedWorkout> _completedWorkouts =
        CompletedWorkoutsState().completedWorkoutList;
    _completedWorkouts.sort((CompletedWorkout a, CompletedWorkout b) =>
        a.completedLocalDate.compareTo(b.completedLocalDate));
    _totalHangData = _completedWorkouts
        .map((CompletedWorkout c) => TotalHangRestTimeData(
            label: c.workout.label,
            workoutId: c.workout.id,
            date: c.completedLocalDate,
            seconds: c.history.timerUnderTensionMs ~/ 1000))
        .toList();
    _totalRestData = _completedWorkouts
        .map((CompletedWorkout c) => TotalHangRestTimeData(
            label: c.workout.label,
            workoutId: c.workout.id,
            date: c.completedLocalDate,
            seconds: c.history.totalRestTimeMs ~/ 1000))
        .toList();

    _filteredHangData = _totalHangData;
    _filteredRestData = _totalRestData;

    final List<DateTime> _dateRange = _completedWorkouts
        .map((CompletedWorkout c) => c.completedLocalDate)
        .toList();

    DateTime _startDate;
    DateTime _endDate;
    if (_dateRange.length > 0) {
      _startDate = _dateRange.first;
      _endDate = _dateRange.last;
    }

    _state = TotalHangRestTimeViewModelState(
        filteredWorkout: null,
        filteredLabel: null,
        dateRange: _dateRange,
        startDate: _startDate,
        endDate: _endDate,
        hangData: _filteredHangData,
        restData: _filteredRestData,
        selectedDateOnChart: _startDate,
        hangSecondsForSelectedDate: _getHangSecondsForSelectedDate(_startDate),
        restSecondsForSelectedDate: _getRestSecondsForSelectedDate(_startDate));
  }

  int _getHangSecondsForSelectedDate(DateTime dateTime) {
    return _totalHangData
        .firstWhere((TotalHangRestTimeData data) => data.date == dateTime)
        .seconds;
  }

  int _getRestSecondsForSelectedDate(DateTime dateTime) {
    return _totalRestData
        .firstWhere((TotalHangRestTimeData data) => data.date == dateTime)
        .seconds;
  }

  void _setNewDates({DateTime startDate, DateTime endDate}) {
    DateTime _startDate = startDate;
    DateTime _endDate = endDate;

    if (_endDate == null) {
      _endDate = state.endDate;
    }
    if (_startDate == null) {
      _startDate = state.startDate;
    }

    List<TotalHangRestTimeData> _newHangData = [];
    List<TotalHangRestTimeData> _newRestData = [];

    if (_startDate.isBefore(_endDate) ||
        _startDate.isAtSameMomentAs(_endDate)) {
      _newHangData = _filteredHangData
          .where((TotalHangRestTimeData data) =>
              (data.date.isAfter(_startDate) && data.date.isBefore(_endDate)) ||
              data.date.isAtSameMomentAs(_startDate) ||
              data.date.isAtSameMomentAs(_endDate))
          .toList();

      _newRestData = _filteredRestData
          .where((TotalHangRestTimeData data) =>
              (data.date.isAfter(_startDate) && data.date.isBefore(_endDate)) ||
              data.date.isAtSameMomentAs(_startDate) ||
              data.date.isAtSameMomentAs(_endDate))
          .toList();
    }

    _state = state.copyWith(
        startDate: _startDate,
        endDate: _endDate,
        hangData: _newHangData,
        restData: _newRestData);
    notifyListeners();
  }

  void setStartDate(DateTime startDate) {
    _setNewDates(startDate: startDate);
  }

  void setEndDate(DateTime endDate) {
    _setNewDates(endDate: endDate);
  }

  void setSelectedDateOnChart(DateTime date) {
    _state = state.copyWith(
        selectedDateOnChart: date,
        hangSecondsForSelectedDate: _getHangSecondsForSelectedDate(date),
        restSecondsForSelectedDate: _getRestSecondsForSelectedDate(date));
    notifyListeners();
  }

  void handleFilterTap() async {
    final _newFilters = await _navigationService.pushNamed(Routes.filterScreen,
        arguments: FilterScreenArguments(
            filteredWorkout: state.filteredWorkout,
            filteredLabel: state.filteredLabel));

    final Workout _filteredWorkout =
        (_newFilters as FilterScreenArguments).filteredWorkout;
    final Label _filteredLabel =
        (_newFilters as FilterScreenArguments).filteredLabel;

    if (_filteredWorkout != null) {
      _filteredHangData = _totalHangData
          .where((TotalHangRestTimeData data) =>
              data.workoutId == _filteredWorkout.id)
          .toList();
      _filteredRestData = _totalRestData
          .where((TotalHangRestTimeData data) =>
              data.workoutId == _filteredWorkout.id)
          .toList();
    }

    if (_filteredLabel != null) {
      _filteredHangData = _totalHangData
          .where((TotalHangRestTimeData data) => data.label == _filteredLabel)
          .toList();
      _filteredRestData = _totalRestData
          .where((TotalHangRestTimeData data) => data.label == _filteredLabel)
          .toList();
    }

    if (_filteredWorkout == null && _filteredLabel == null) {
      _filteredHangData = _totalHangData;
      _filteredRestData = _totalRestData;
    }

    _state = state.copyWith(
        filteredLabel: Nullable(_filteredLabel),
        filteredWorkout: Nullable(_filteredWorkout));

    _setNewDates(startDate: state.startDate, endDate: state.endDate);
  }
}
