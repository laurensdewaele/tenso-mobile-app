import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:tenso_app/helpers/nullable.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/screens/filter.screen.dart';
import 'package:tenso_app/services/navigation.service.dart';
import 'package:tenso_app/state/completed_workouts.state.dart';
import 'package:tenso_app/view_models/stats/filter_state.vm.dart';
import 'package:tenso_app/widgets/label_text_picker.dart';

class FilterViewModel extends ChangeNotifier {
  FilterViewModel({Label filteredLabel, Workout filteredWorkout}) {
    _navigationService = NavigationService();
    _completedWorkoutsState = CompletedWorkoutsState();
    _state = FilterViewModelState(
      selectedLabel: filteredLabel,
      selectedWorkout: filteredWorkout,
      workoutsWithCompletedAmount: _getWorkoutsWithCompletedAmount(),
      labelsWithText: _getLabelsWithText(),
    );
  }

  CompletedWorkoutsState _completedWorkoutsState;
  NavigationService _navigationService;

  final StreamController<bool> _resetLabelPicker$ = StreamController();
  Stream<bool> get resetLabelPicker$ => _resetLabelPicker$.stream;

  FilterViewModelState _state;
  FilterViewModelState get state => _state;

  setSelectedLabel(Label label) {
    _state = state.copyWith(
        selectedLabel: Nullable(label), selectedWorkout: Nullable(null));
    notifyListeners();
  }

  setSelectedWorkout(Workout workout) {
    _state = state.copyWith(
        selectedWorkout: Nullable(workout), selectedLabel: Nullable(null));
    _resetLabelPicker$.sink.add(true);
    notifyListeners();
  }

  List<WorkoutWithCompletedAmount> _getWorkoutsWithCompletedAmount() {
    List<Workout> _completedWorkouts = _completedWorkoutsState
        .completedWorkoutList
        .map((CompletedWorkout c) => c.workout)
        .toList();

    List<WorkoutWithCompletedAmount> _workoutsWithCompletedAmount = [];

    _completedWorkouts.forEach((Workout w) {
      if (!_workoutsWithCompletedAmount
          .map((WorkoutWithCompletedAmount w) => w.workout.id)
          .contains(w.id)) {
        final int _completedAmount =
            _completedWorkouts.where((Workout _w) => w.id == _w.id).length;
        _workoutsWithCompletedAmount.add(WorkoutWithCompletedAmount(
          workout: w,
          completedAmount: _completedAmount,
        ));
      }
    });

    _workoutsWithCompletedAmount
        .sort((a, b) => b.completedAmount.compareTo(a.completedAmount));

    return _workoutsWithCompletedAmount;
  }

  List<LabelWithText> _getLabelsWithText() {
    List<Label> _completedLabels = _completedWorkoutsState.completedWorkoutList
        .map((CompletedWorkout c) => c.workout.label)
        .toList();

    List<LabelWithCompletedAmount> _labelsWithCompletedAmount = [];

    _completedLabels.forEach((Label label) {
      if (!_labelsWithCompletedAmount
          .map((LabelWithCompletedAmount l) => l.label)
          .contains(label)) {
        final int _completedAmount =
            _completedLabels.where((Label _label) => label == _label).length;
        _labelsWithCompletedAmount.add(LabelWithCompletedAmount(
            label: label, completedAmount: _completedAmount));
      }
    });

    String getCompletedAmountForLabel(Label label) {
      final int _completedAmount = _labelsWithCompletedAmount
          .firstWhere((LabelWithCompletedAmount c) => c.label == label,
              orElse: () => null)
          ?.completedAmount;

      return _completedAmount == null ? '0X' : '${_completedAmount}X';
    }

    List<LabelWithText> _labelsWithText = defaultLabelsWithText
        .map((LabelWithText l) =>
            l.copyWith(text: Nullable(getCompletedAmountForLabel(l.label))))
        .toList();

    return _labelsWithText;
  }

  void handleBackNavigation() {
    _navigationService.pop<FilterScreenArguments>(FilterScreenArguments(
        filteredWorkout: state.selectedWorkout,
        filteredLabel: state.selectedLabel));
  }

  void handleClearTap() {
    _resetLabelPicker$.sink.add(true);
    _state = state.copyWith(
        selectedLabel: Nullable(null), selectedWorkout: Nullable(null));
    notifyListeners();
  }

  void handleApplyTap() {
    handleBackNavigation();
  }

  @override
  void dispose() {
    _resetLabelPicker$.close();
    super.dispose();
  }
}
