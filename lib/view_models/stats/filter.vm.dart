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
      selectedLabel: filteredLabel ?? null,
      selectedWorkout: filteredWorkout ?? null,
      completedWorkoutsByAmount: _getCompletedWorkoutsByAmount(),
      labelsWithText: _getLabelsWithText(),
    );
  }

  CompletedWorkoutsState _completedWorkoutsState;
  NavigationService _navigationService;

  final StreamController<bool> _reset$ = StreamController.broadcast();
  Stream<bool> get reset$ => _reset$.stream;

  FilterViewModelState _state;
  FilterViewModelState get state => _state;

  setSelectedLabel(Label label) {
    _state = state.copyWith(
        selectedLabel: Nullable<Label>(label), selectedWorkout: Nullable(null));
  }

  setSelectedWorkout(Workout workout) {
    _state = state.copyWith(
        selectedWorkout: Nullable<Workout>(workout),
        selectedLabel: Nullable(null));
  }

  List<WorkoutCompletedAmount> _getCompletedWorkoutsByAmount() {
    List<Workout> _completedWorkouts = _completedWorkoutsState
        .completedWorkoutList
        .map((CompletedWorkout c) => c.workout)
        .toList();

    List<WorkoutCompletedAmount> _completedWorkoutsByAmount = [];

    _completedWorkouts.forEach((Workout w) {
      if (!_completedWorkoutsByAmount
          .map((WorkoutCompletedAmount w) => w.workoutId)
          .contains(w.id)) {
        final int _completedAmount =
            _completedWorkouts.where((Workout _w) => w.id == _w.id).length;
        _completedWorkoutsByAmount.add(WorkoutCompletedAmount(
            workoutId: w.id,
            completedAmount: _completedAmount,
            label: w.label,
            workoutName: w.name));
      }
    });

    return _completedWorkoutsByAmount;
  }

  List<LabelWithText> _getLabelsWithText() {
    List<Label> _completedLabels = _completedWorkoutsState.completedWorkoutList
        .map((CompletedWorkout c) => c.workout.label)
        .toList();

    List<LabelCompletedAmount> _completedLabelsByAmount = [];

    _completedLabels.forEach((Label label) {
      if (!_completedLabelsByAmount
          .map((LabelCompletedAmount l) => l.label)
          .contains(label)) {
        final int _completedAmount =
            _completedLabels.where((Label _label) => label == _label).length;
        _completedLabelsByAmount.add(LabelCompletedAmount(
            label: label, completedAmount: _completedAmount));
      }
    });

    String getCompletedAmountForLabel(Label label) {
      final int _completedAmount = _completedLabelsByAmount
          .firstWhere((LabelCompletedAmount c) => c.label == label,
              orElse: () => null)
          ?.completedAmount;

      return _completedAmount == null ? '0X' : '${_completedAmount}X';
    }

    List<LabelWithText> _labelsWithText = [
      LabelWithText(
          label: Label.black, text: getCompletedAmountForLabel(Label.black)),
      LabelWithText(
          label: Label.red, text: getCompletedAmountForLabel(Label.red)),
      LabelWithText(
          label: Label.orange, text: getCompletedAmountForLabel(Label.orange)),
      LabelWithText(
          label: Label.yellow, text: getCompletedAmountForLabel(Label.yellow)),
      LabelWithText(
          label: Label.turquoise,
          text: getCompletedAmountForLabel(Label.turquoise)),
      LabelWithText(
          label: Label.blue, text: getCompletedAmountForLabel(Label.blue)),
      LabelWithText(
          label: Label.purple, text: getCompletedAmountForLabel(Label.purple)),
    ];

    return _labelsWithText;
  }

  void handleBackNavigation() {
    _navigationService.pop<FilterScreenArguments>(FilterScreenArguments(
        filteredWorkout: state.selectedWorkout,
        filteredLabel: state.selectedLabel));
  }

  @override
  void dispose() {
    _reset$.close();
    super.dispose();
  }
}