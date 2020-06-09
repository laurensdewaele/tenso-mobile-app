import 'dart:ui';

import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

@immutable
class WorkoutViewModelState2 {
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

  WorkoutViewModelState2.addWorkout(
      Workout workout, WeightSystem currentWeightSystem)
      : label = workout.label,
        groups = workout.groups.toList(),
        restBetweenGroupsFixed = workout.restBetweenGroupsFixed,
        restBetweenGroupsS = workout.restBetweenGroupsS,
        restBetweenGroupsSInput = workout.restBetweenGroupsS.toString(),
        name = workout.name,
        nameInput = workout.name,
        weightSystem = currentWeightSystem,
        saveButtonText = 'add',
        inputsEnabled = true,
        primaryColor = styles.Colors.primary,
        textPrimaryColor = styles.Lato.xsPrimary,
        title = 'New workout';

  WorkoutViewModelState2.editWorkout(
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

  WorkoutViewModelState2.viewWorkout(
      Workout workout, WeightSystem currentWeightSystem)
      : label = workout.label,
        groups = workout.groups.toList(),
        restBetweenGroupsFixed = workout.restBetweenGroupsFixed,
        restBetweenGroupsS = workout.restBetweenGroupsS,
        restBetweenGroupsSInput = workout.restBetweenGroupsS.toString(),
        name = workout.name,
        nameInput = workout.name,
        weightSystem = currentWeightSystem,
        saveButtonText = 'back',
        inputsEnabled = false,
        primaryColor = styles.Colors.gray,
        textPrimaryColor = styles.Lato.xsGray,
        title = 'View workout';

  const WorkoutViewModelState2({
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

  WorkoutViewModelState2 copyWith({
    Label label,
    List<Group> groups,
    int restBetweenGroupsS,
    String restBetweenGroupsSInput,
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
    return new WorkoutViewModelState2(
      label: label ?? this.label,
      groups: groups ?? this.groups,
      restBetweenGroupsS: restBetweenGroupsS ?? this.restBetweenGroupsS,
      restBetweenGroupsSInput:
          restBetweenGroupsSInput ?? this.restBetweenGroupsSInput,
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