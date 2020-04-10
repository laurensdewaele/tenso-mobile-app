import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

import 'package:rxdart/subjects.dart';

import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;

enum WorkoutTypes { newWorkout, editWorkout, viewWorkout }

@immutable
class WorkoutTypesVariables {
  final String extraTabButtonText;
  final bool inputsEnabled;
  final Color primaryColor;
  final TextStyle textPrimaryColor;
  final String title;

  const WorkoutTypesVariables({
    @required this.extraTabButtonText,
    @required this.inputsEnabled,
    @required this.primaryColor,
    @required this.textPrimaryColor,
    @required this.title,
  });
}

WorkoutTypesVariables _newWorkoutVariables = WorkoutTypesVariables(
    extraTabButtonText: 'add',
    inputsEnabled: true,
    primaryColor: styles.Colors.primary,
    textPrimaryColor: styles.Lato.xsPrimary,
    title: 'New workout');

WorkoutTypesVariables _editWorkoutVariables = WorkoutTypesVariables(
    extraTabButtonText: 'done',
    inputsEnabled: true,
    primaryColor: styles.Colors.blue,
    textPrimaryColor: styles.Lato.xsBlue,
    title: 'Edit workout');

WorkoutTypesVariables _viewWorkoutVariables = WorkoutTypesVariables(
    extraTabButtonText: 'back',
    inputsEnabled: false,
    primaryColor: styles.Colors.gray,
    textPrimaryColor: styles.Lato.xsGray,
    title: 'View workout');

class WorkoutViewModel {
  WorkoutTypesVariables _workoutTypesVariables;
  WorkoutTypesVariables get workoutTypesVariables => _workoutTypesVariables;

  BehaviorSubject<WorkoutViewModelState> _state$;
  WorkoutViewModelState get _state => _state$.value;
  Stream<WorkoutViewModelState> get state$ => _state$.stream;

  WorkoutViewModel({
    @required WorkoutTypes workoutType,
    @required Workout workout,
    @required WeightUnit currentWeightUnit,
    // TODO: App state => workoutState
  }) {
    _setWorkoutTypeVars(workoutType);
    _state$ = BehaviorSubject.seeded(
        WorkoutViewModelState.fromWorkout(workout, currentWeightUnit));
  }

  void _setWorkoutTypeVars(WorkoutTypes workoutType) {
    switch (workoutType) {
      case WorkoutTypes.editWorkout:
        _workoutTypesVariables = _editWorkoutVariables;
        break;
      case WorkoutTypes.newWorkout:
        _workoutTypesVariables = _newWorkoutVariables;
        break;
      case WorkoutTypes.viewWorkout:
        _workoutTypesVariables = _viewWorkoutVariables;
        break;
    }
  }

  void dispose() {
    _state$.close();
  }

  void setGeneralVariables(
      {@required int holdCount,
      @required int sets,
      @required int restBetweenHolds,
      @required int restBetweenSets,
      @required Board board}) {
    _state$.add(_state.copyWith(
        holdCount: holdCount,
        sets: sets,
        restBetweenHolds: restBetweenHolds,
        restBetweenSets: restBetweenSets,
        board: board,
        holds: _generateHoldsFromHoldCount(holdCount)));
  }

  void setHoldVariables(
      {@required Grip leftGrip,
      @required Grip rightGrip,
      @required BoardHold leftGripBoardHold,
      @required BoardHold rightGripBoardHold,
      @required int repetitions,
      @required int hangTime,
      @required int restBetweenRepetitions,
      @required double addedWeight,
      @required HandHold handHold,
      @required int holdIndex}) {
    if (holdIndex != null) {
      final Hold _newHold = Hold((b) => b
        ..leftGrip = leftGrip?.toBuilder() ?? null
        ..rightGrip = rightGrip?.toBuilder() ?? null
        ..leftGripBoardHold = leftGripBoardHold?.toBuilder() ?? null
        ..rightGripBoardHold = rightGripBoardHold?.toBuilder() ?? null
        ..repetitions = repetitions
        ..hangTime = hangTime
        ..restBetweenRepetitions = restBetweenRepetitions
        ..addedWeight = addedWeight
        ..handHold = handHold);

      final List<Hold> _newHolds = []..addAll(_state.holds);
      _newHolds[holdIndex] = _newHold;
      _state$.add(_state.copyWith(holds: _newHolds));
    }
  }

  void setExtraVariables({@required Label label, @required String name}) {
    _state$.add(_state.copyWith(label: label, name: name));
  }

  List<Hold> _generateHoldsFromHoldCount(int count) {
    if (count == _state.holdCount) {
      return _state.holds;
    }

    List<Hold> _holds;
    if (count < _state.holdCount) {
      _holds = _state.holds.take(count).toList();
    }
    if (count > _state.holdCount) {
      final Hold defaultHold = _state.holds[0];
      final int difference = count - _state.holdCount;
      _holds = [
        ..._state.holds,
        ...List.generate(difference, (i) => defaultHold)
      ];
    }
    return _holds;
  }
}

@immutable
class WorkoutViewModelState {
  final Label label;
  final int sets;
  final int holdCount;
  final int restBetweenHolds;
  final int restBetweenSets;
  final Board board;
  final List<Hold> holds;
  final String name;
  final WeightUnit weightUnit;

  final listEquality = const ListEquality<Hold>();

  const WorkoutViewModelState({
    @required this.label,
    @required this.sets,
    @required this.holdCount,
    @required this.restBetweenHolds,
    @required this.restBetweenSets,
    @required this.board,
    @required this.holds,
    @required this.name,
    @required this.weightUnit,
  });

  WorkoutViewModelState.fromWorkout(
      Workout workout, WeightUnit currentWeightUnit)
      : label = workout.label,
        sets = workout.sets,
        holdCount = workout.holdCount,
        restBetweenHolds = workout.restBetweenHolds,
        restBetweenSets = workout.restBetweenSets,
        board = workout.board,
        holds = workout.holds.toList(),
        name = workout.name,
        weightUnit = currentWeightUnit;

  WorkoutViewModelState copyWith({
    Label label,
    int sets,
    int holdCount,
    int restBetweenHolds,
    int restBetweenSets,
    Board board,
    List<Hold> holds,
    String name,
    WeightUnit weightUnit,
  }) {
    return WorkoutViewModelState(
      label: label ?? this.label,
      sets: sets ?? this.sets,
      holdCount: holdCount ?? this.holdCount,
      restBetweenHolds: restBetweenHolds ?? this.restBetweenHolds,
      restBetweenSets: restBetweenSets ?? this.restBetweenSets,
      board: board ?? this.board,
      holds: holds ?? this.holds,
      name: name ?? this.name,
      weightUnit: weightUnit ?? this.weightUnit,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutViewModelState &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          sets == other.sets &&
          holdCount == other.holdCount &&
          restBetweenHolds == other.restBetweenHolds &&
          restBetweenSets == other.restBetweenSets &&
          board == other.board &&
          listEquality.equals(holds, other.holds) &&
          name == other.name &&
          weightUnit == other.weightUnit;

  @override
  int get hashCode =>
      label.hashCode ^
      sets.hashCode ^
      holdCount.hashCode ^
      restBetweenHolds.hashCode ^
      restBetweenSets.hashCode ^
      board.hashCode ^
      holds.hashCode ^
      name.hashCode ^
      weightUnit.hashCode;

  @override
  String toString() {
    return 'WorkoutViewModelState{label: $label, sets: $sets, holdCount: $holdCount, restBetweenHolds: $restBetweenHolds, restBetweenSets: $restBetweenSets, board: $board, holds: $holds, name: $name, weightUnit: $weightUnit}';
  }
}
