import 'package:flutter/cupertino.dart';
import 'package:tenso_app/helpers/nullable.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/widgets/label_text_picker.dart';

class WorkoutWithCompletedAmount {
  final Workout workout;
  final int completedAmount;

  const WorkoutWithCompletedAmount({
    @required this.workout,
    @required this.completedAmount,
  });
}

class LabelWithCompletedAmount {
  final Label label;
  final int completedAmount;

  const LabelWithCompletedAmount({
    @required this.label,
    @required this.completedAmount,
  });
}

class FilterViewModelState {
  Label selectedLabel;
  Workout selectedWorkout;
  List<WorkoutWithCompletedAmount> completedWorkoutsByAmount;
  List<LabelWithText> labelsWithText;
  LabelWithText get initialLabelWithText =>
      labelsWithText.firstWhere((LabelWithText l) => l.label == selectedLabel,
          orElse: () => null);

  FilterViewModelState({
    this.selectedLabel,
    this.selectedWorkout,
    @required this.completedWorkoutsByAmount,
    @required this.labelsWithText,
  });

  FilterViewModelState copyWith({
    Nullable<Label> selectedLabel,
    List<LabelWithText> labelsWithText,
    Nullable<Workout> selectedWorkout,
    List<WorkoutWithCompletedAmount> completedWorkoutsByAmount,
  }) {
    return new FilterViewModelState(
      selectedLabel:
          selectedLabel == null ? this.selectedLabel : selectedLabel.value,
      selectedWorkout: selectedWorkout == null
          ? this.selectedWorkout
          : selectedWorkout.value,
      completedWorkoutsByAmount:
          completedWorkoutsByAmount ?? this.completedWorkoutsByAmount,
      labelsWithText: labelsWithText ?? this.labelsWithText,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterViewModelState &&
          runtimeType == other.runtimeType &&
          selectedLabel == other.selectedLabel &&
          selectedWorkout == other.selectedWorkout &&
          completedWorkoutsByAmount == other.completedWorkoutsByAmount &&
          labelsWithText == other.labelsWithText;

  @override
  int get hashCode =>
      selectedLabel.hashCode ^
      selectedWorkout.hashCode ^
      completedWorkoutsByAmount.hashCode ^
      labelsWithText.hashCode;
}
