import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;

@immutable
class WorkoutViewModelState {
  final String id;
  final Label label;
  final int sets;
  final int holdCount;
  final int restBetweenHolds;
  final int restBetweenSets;
  final Board board;
  final List<Hold> holds;
  final String name;
  final WeightUnit weightUnit;

  final String extraTabButtonText;
  final bool inputsEnabled;
  final Color primaryColor;
  final TextStyle textPrimaryColor;
  final String title;

  final listEquality = const ListEquality<Hold>();

  const WorkoutViewModelState({
    @required this.id,
    @required this.label,
    @required this.sets,
    @required this.holdCount,
    @required this.restBetweenHolds,
    @required this.restBetweenSets,
    @required this.board,
    @required this.holds,
    @required this.name,
    @required this.weightUnit,
    @required this.extraTabButtonText,
    @required this.inputsEnabled,
    @required this.primaryColor,
    @required this.textPrimaryColor,
    @required this.title,
  });

  WorkoutViewModelState.addWorkout(
      Workout workout, WeightUnit currentWeightUnit)
      : id = workout.id,
        label = workout.label,
        sets = workout.sets,
        holdCount = workout.holdCount,
        restBetweenHolds = workout.restBetweenHolds,
        restBetweenSets = workout.restBetweenSets,
        board = workout.board,
        holds = workout.holds.toList(),
        name = workout.name,
        weightUnit = currentWeightUnit,
        extraTabButtonText = 'add',
        inputsEnabled = true,
        primaryColor = styles.Colors.primary,
        textPrimaryColor = styles.Lato.xsPrimary,
        title = 'New workout';

  WorkoutViewModelState.editWorkout(
      Workout workout, WeightUnit currentWeightUnit)
      : id = workout.id,
        label = workout.label,
        sets = workout.sets,
        holdCount = workout.holdCount,
        restBetweenHolds = workout.restBetweenHolds,
        restBetweenSets = workout.restBetweenSets,
        board = workout.board,
        holds = workout.holds.toList(),
        name = workout.name,
        weightUnit = currentWeightUnit,
        extraTabButtonText = 'done',
        inputsEnabled = true,
        primaryColor = styles.Colors.blue,
        textPrimaryColor = styles.Lato.xsBlue,
        title = 'Edit workout';

  WorkoutViewModelState.viewWorkout(
      Workout workout, WeightUnit currentWeightUnit)
      : id = workout.id,
        label = workout.label,
        sets = workout.sets,
        holdCount = workout.holdCount,
        restBetweenHolds = workout.restBetweenHolds,
        restBetweenSets = workout.restBetweenSets,
        board = workout.board,
        holds = workout.holds.toList(),
        name = workout.name,
        weightUnit = currentWeightUnit,
        extraTabButtonText = 'back',
        inputsEnabled = false,
        primaryColor = styles.Colors.gray,
        textPrimaryColor = styles.Lato.xsGray,
        title = 'View workout';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutViewModelState &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          label == other.label &&
          sets == other.sets &&
          holdCount == other.holdCount &&
          restBetweenHolds == other.restBetweenHolds &&
          restBetweenSets == other.restBetweenSets &&
          board == other.board &&
          listEquality.equals(holds, other.holds) &&
          name == other.name &&
          weightUnit == other.weightUnit &&
          extraTabButtonText == other.extraTabButtonText &&
          inputsEnabled == other.inputsEnabled &&
          primaryColor == other.primaryColor &&
          textPrimaryColor == other.textPrimaryColor &&
          title == other.title &&
          listEquality == other.listEquality;

  @override
  int get hashCode =>
      id.hashCode ^
      label.hashCode ^
      sets.hashCode ^
      holdCount.hashCode ^
      restBetweenHolds.hashCode ^
      restBetweenSets.hashCode ^
      board.hashCode ^
      holds.hashCode ^
      name.hashCode ^
      weightUnit.hashCode ^
      extraTabButtonText.hashCode ^
      inputsEnabled.hashCode ^
      primaryColor.hashCode ^
      textPrimaryColor.hashCode ^
      title.hashCode ^
      listEquality.hashCode;

  WorkoutViewModelState copyWith({
    String id,
    Label label,
    int sets,
    int holdCount,
    int restBetweenHolds,
    int restBetweenSets,
    Board board,
    List<Hold> holds,
    String name,
    WeightUnit weightUnit,
    String extraTabButtonText,
    bool inputsEnabled,
    Color primaryColor,
    TextStyle textPrimaryColor,
    String title,
  }) {
    return new WorkoutViewModelState(
      id: id ?? this.id,
      label: label ?? this.label,
      sets: sets ?? this.sets,
      holdCount: holdCount ?? this.holdCount,
      restBetweenHolds: restBetweenHolds ?? this.restBetweenHolds,
      restBetweenSets: restBetweenSets ?? this.restBetweenSets,
      board: board ?? this.board,
      holds: holds ?? this.holds,
      name: name ?? this.name,
      weightUnit: weightUnit ?? this.weightUnit,
      extraTabButtonText: extraTabButtonText ?? this.extraTabButtonText,
      inputsEnabled: inputsEnabled ?? this.inputsEnabled,
      primaryColor: primaryColor ?? this.primaryColor,
      textPrimaryColor: textPrimaryColor ?? this.textPrimaryColor,
      title: title ?? this.title,
    );
  }
}
