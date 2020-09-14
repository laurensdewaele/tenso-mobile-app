import 'package:flutter/cupertino.dart';
import 'package:tenso_app/helpers/nullable.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/widgets/label_text_picker.dart';

class WorkoutCompletedAmount {
  final String workoutId;
  final String workoutName;
  final Label label;
  final int completedAmount;

  const WorkoutCompletedAmount({
    @required this.workoutId,
    @required this.workoutName,
    @required this.label,
    @required this.completedAmount,
  });
}

class LabelCompletedAmount {
  final Label label;
  final int completedAmount;

  const LabelCompletedAmount({
    @required this.label,
    @required this.completedAmount,
  });
}

class FilterViewModelState {
  Label selectedLabel;
  Workout selectedWorkout;
  List<WorkoutCompletedAmount> completedWorkoutsByAmount;
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
    List<WorkoutCompletedAmount> completedWorkoutsByAmount,
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
