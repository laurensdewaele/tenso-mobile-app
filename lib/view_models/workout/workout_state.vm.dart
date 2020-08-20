import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:tenso_app/helpers/nullable.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

@immutable
class WorkoutViewModelState {
  final Label label;
  final List<Group> groups;
  final int restBetweenGroupsS;
  final String restBetweenGroupsSInput;
  final bool restBetweenGroupsFixed;

  final String name;
  final String nameInput;
  final WeightSystem weightSystem;

  final String saveButtonText;
  final bool inputsEnabled;
  final Color primaryColor;
  final TextStyle textPrimaryColor;
  final String title;

  WorkoutViewModelState.addWorkout(
      Workout workout, WeightSystem currentWeightSystem)
      : label = workout.label,
        groups = workout.groups.toList(),
        restBetweenGroupsFixed = workout.restBetweenGroupsFixed,
        restBetweenGroupsS = workout.restBetweenGroupsS,
        restBetweenGroupsSInput = workout.restBetweenGroupsS.toString(),
        name = workout.name,
        nameInput = workout.name,
        weightSystem = currentWeightSystem,
        saveButtonText = 'save',
        inputsEnabled = true,
        primaryColor = styles.Colors.primary,
        textPrimaryColor = styles.Lato.xsPrimary,
        title = 'New workout';

  WorkoutViewModelState.editWorkout(
      Workout workout, WeightSystem currentWeightSystem)
      : label = workout.label,
        groups = workout.groups.toList(),
        restBetweenGroupsFixed = workout.restBetweenGroupsFixed,
        restBetweenGroupsS = workout.restBetweenGroupsS,
        restBetweenGroupsSInput = workout.restBetweenGroupsS.toString(),
        name = workout.name,
        nameInput = workout.name,
        weightSystem = currentWeightSystem,
        saveButtonText = 'save',
        inputsEnabled = true,
        primaryColor = styles.Colors.blue,
        textPrimaryColor = styles.Lato.xsBlue,
        title = 'Edit workout';

  const WorkoutViewModelState({
    @required this.label,
    @required this.groups,
    @required this.restBetweenGroupsS,
    @required this.restBetweenGroupsSInput,
    @required this.restBetweenGroupsFixed,
    @required this.name,
    @required this.nameInput,
    @required this.weightSystem,
    @required this.saveButtonText,
    @required this.inputsEnabled,
    @required this.primaryColor,
    @required this.textPrimaryColor,
    @required this.title,
  });

  WorkoutViewModelState copyWith({
    Label label,
    List<Group> groups,
    Nullable<int> restBetweenGroupsS,
    Nullable<String> restBetweenGroupsSInput,
    bool restBetweenGroupsFixed,
    String name,
    String nameInput,
    WeightSystem weightSystem,
    String saveButtonText,
    bool inputsEnabled,
    Color primaryColor,
    TextStyle textPrimaryColor,
    String title,
  }) {
    return new WorkoutViewModelState(
      label: label ?? this.label,
      groups: groups ?? this.groups,
      restBetweenGroupsS: restBetweenGroupsS == null
          ? this.restBetweenGroupsS
          : restBetweenGroupsS.value,
      restBetweenGroupsSInput: restBetweenGroupsSInput == null
          ? this.restBetweenGroupsSInput
          : restBetweenGroupsSInput.value,
      restBetweenGroupsFixed:
          restBetweenGroupsFixed ?? this.restBetweenGroupsFixed,
      name: name ?? this.name,
      nameInput: nameInput ?? this.nameInput,
      weightSystem: weightSystem ?? this.weightSystem,
      saveButtonText: saveButtonText ?? this.saveButtonText,
      inputsEnabled: inputsEnabled ?? this.inputsEnabled,
      primaryColor: primaryColor ?? this.primaryColor,
      textPrimaryColor: textPrimaryColor ?? this.textPrimaryColor,
      title: title ?? this.title,
    );
  }
}
