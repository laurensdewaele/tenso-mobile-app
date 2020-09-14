import 'package:flutter/cupertino.dart';
import 'package:tenso_app/helpers/nullable.dart';
import 'package:tenso_app/models/completed_workout.model.dart';
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

  TotalHangRestTimeViewModel() {
    _navigationService = NavigationService();

    final List<CompletedWorkout> _completedWorkouts =
        CompletedWorkoutsState().completedWorkoutList;
    _completedWorkouts.sort((CompletedWorkout a, CompletedWorkout b) =>
        a.completedLocalDate.compareTo(b.completedLocalDate));
    _totalHangData = _completedWorkouts
        .map((CompletedWorkout c) => TotalHangRestTimeData(
            date: c.completedLocalDate,
            seconds: c.history.timerUnderTensionMs ~/ 1000))
        .toList();
    _totalRestData = _completedWorkouts
        .map((CompletedWorkout c) => TotalHangRestTimeData(
            date: c.completedLocalDate,
            seconds: c.history.totalRestTimeMs ~/ 1000))
        .toList();

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
        dateRange: _dateRange,
        startDate: _startDate,
        endDate: _endDate,
        rangeFilter: null,
        hangData: _totalHangData,
        restData: _totalRestData,
        selectedDate: _startDate,
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
    DateTime _checkIsAtSameMomentAsDate;
    DateTime _startDate = startDate;
    DateTime _endDate = endDate;

    if (_endDate == null) {
      _checkIsAtSameMomentAsDate = startDate;
      _endDate = state.endDate;
    }
    if (_startDate == null) {
      _checkIsAtSameMomentAsDate = endDate;
      _startDate = state.startDate;
    }

    List<TotalHangRestTimeData> _newHangData = [];
    List<TotalHangRestTimeData> _newRestData = [];

    if (_startDate.isBefore(_endDate) ||
        _startDate.isAtSameMomentAs(_endDate)) {
      _newHangData = _totalHangData
          .where((TotalHangRestTimeData data) =>
              (data.date.isAfter(_startDate) && data.date.isBefore(_endDate)) ||
              data.date.isAtSameMomentAs(_checkIsAtSameMomentAsDate))
          .toList();

      _newRestData = _totalRestData
          .where((TotalHangRestTimeData data) =>
              (data.date.isAfter(_startDate) && data.date.isBefore(_endDate)) ||
              data.date.isAtSameMomentAs(_checkIsAtSameMomentAsDate))
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

  void setSelectedDate(DateTime date) {
    _state = state.copyWith(
        selectedDate: date,
        hangSecondsForSelectedDate: _getHangSecondsForSelectedDate(date),
        restSecondsForSelectedDate: _getRestSecondsForSelectedDate(date));
    notifyListeners();
  }

  void handleFilterTap() async {
    final FilterScreenArguments _newFilters =
        await _navigationService.pushNamed(Routes.filterScreen,
            arguments: FilterScreenArguments(
                filteredWorkout: state.filteredWorkout,
                filteredLabel: state.filteredLabel));
    _state = state.copyWith(
        filteredLabel: Nullable(_newFilters.filteredLabel),
        filteredWorkout: Nullable(_newFilters.filteredWorkout));
  }
}
