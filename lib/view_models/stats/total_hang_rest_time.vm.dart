import 'package:flutter/cupertino.dart';
import 'package:tenso_app/models/completed_workout.model.dart';
import 'package:tenso_app/state/completed_workouts.state.dart';
import 'package:tenso_app/view_models/stats/total_hang_rest_time_state.vm.dart';
import 'package:tenso_app/widgets/stats/total_hang_rest_time/total_hang_rest_time_chart.dart';

class TotalHangRestTimeViewModel extends ChangeNotifier {
  TotalHangRestTimeViewModelState _state;
  TotalHangRestTimeViewModelState get state => _state;

  List<TotalHangRestTimeData> _totalHangData;
  List<TotalHangRestTimeData> _totalRestData;

  TotalHangRestTimeViewModel() {
    final List<CompletedWorkout> _completedWorkouts =
        CompletedWorkoutsState().completedWorkoutList;
    _totalHangData = _completedWorkouts
        .map((CompletedWorkout c) => TotalHangRestTimeData(
            date: c.completedLocalDate, seconds: c.workout.timeUnderTension))
        .toList();
    _totalRestData = _completedWorkouts
        .map((CompletedWorkout c) => TotalHangRestTimeData(
            date: c.completedLocalDate, seconds: c.workout.totalRestTime))
        .toList();

    final List<DateTime> _dateRange = _completedWorkouts
        .map((CompletedWorkout c) => c.completedLocalDate)
        .toList();
    final DateTime _startDate = _dateRange.first;
    final DateTime _endDate = _dateRange.last;

    _state = TotalHangRestTimeViewModelState(
        dateRange: _dateRange,
        startDate: _startDate,
        endDate: _endDate,
        rangeFilter: null,
        hangData: _totalHangData,
        restData: _totalRestData);
  }

  void setStartDate(DateTime startDate) {
    _state = state.copyWith(startDate: startDate);
    notifyListeners();
  }

  void setEndDate(DateTime endDate) {
    _state = state.copyWith(endDate: endDate);
    notifyListeners();
  }
}
