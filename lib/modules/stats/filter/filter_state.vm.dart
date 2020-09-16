import 'package:flutter/cupertino.dart';
import 'package:tenso_app/helpers/nullable.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/modules/common/label_with_text_picker.dart';

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
  List<WorkoutWithCompletedAmount> workoutsWithCompletedAmount;
  List<LabelWithText> labelsWithText;
  LabelWithText get initialLabelWithText =>
      labelsWithText.firstWhere((LabelWithText l) => l.label == selectedLabel,
          orElse: () => null);

  FilterViewModelState({
    this.selectedLabel,
    this.selectedWorkout,
    @required this.workoutsWithCompletedAmount,
    @required this.labelsWithText,
  });

  FilterViewModelState copyWith({
    Nullable<Label> selectedLabel,
    List<LabelWithText> labelsWithText,
    Nullable<Workout> selectedWorkout,
    List<WorkoutWithCompletedAmount> workoutsWithCompletedAmount,
  }) {
    return new FilterViewModelState(
      selectedLabel:
          selectedLabel == null ? this.selectedLabel : selectedLabel.value,
      selectedWorkout: selectedWorkout == null
          ? this.selectedWorkout
          : selectedWorkout.value,
      workoutsWithCompletedAmount:
          workoutsWithCompletedAmount ?? this.workoutsWithCompletedAmount,
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
          workoutsWithCompletedAmount == other.workoutsWithCompletedAmount &&
          labelsWithText == other.labelsWithText;

  @override
  int get hashCode =>
      selectedLabel.hashCode ^
      selectedWorkout.hashCode ^
      workoutsWithCompletedAmount.hashCode ^
      labelsWithText.hashCode;
}
