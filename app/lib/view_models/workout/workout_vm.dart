import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

import 'package:rxdart/subjects.dart';

import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;

enum WorkoutTypes { newWorkout, editWorkout, viewWorkout }

class WorkoutViewModel {
  String _extraTabButtonText;
  String get extraTabButtonText => _extraTabButtonText;
  bool _inputsEnabled;
  bool get inputsEnabled => _inputsEnabled;
  Color _primaryColor;
  Color get primaryColor => _primaryColor;
  TextStyle _textPrimaryColor;
  TextStyle get textPrimaryColor => _textPrimaryColor;
  String _title;
  String get title => _title;

  BehaviorSubject<WorkoutViewModelState> _state$;
  WorkoutViewModelState get _state => _state$.value;
  Stream<WorkoutViewModelState> get state$ => _state$.stream;
  Stream<int> holdCount$;

  WorkoutViewModel({
    @required WorkoutTypes workoutType,
    @required Workout workout,
    @required WeightUnit currentWeightUnit,
    // TODO: App state => workoutState
  }) {
    _setWorkoutTypeVars(workoutType);
    _state$ = BehaviorSubject.seeded(
        WorkoutViewModelState.fromWorkout(workout, currentWeightUnit));
    holdCount$ = _state$.map((s) => s.holdCount).distinct();
  }

  void _setWorkoutTypeVars(WorkoutTypes workoutType) {
    switch (workoutType) {
      case WorkoutTypes.editWorkout:
        _extraTabButtonText = 'done';
        _inputsEnabled = true;
        _primaryColor = styles.Colors.blue;
        _textPrimaryColor = styles.Lato.xsBlue;
        _title = 'Edit workout';
        break;
      case WorkoutTypes.newWorkout:
        _extraTabButtonText = 'add';
        _inputsEnabled = true;
        _primaryColor = styles.Colors.primary;
        _textPrimaryColor = styles.Lato.xsPrimary;
        _title = 'New workout';
        break;
      case WorkoutTypes.viewWorkout:
        _extraTabButtonText = 'back';
        _inputsEnabled = false;
        _primaryColor = styles.Colors.gray;
        _textPrimaryColor = styles.Lato.xsGray;
        _title = 'View workout';
        break;
    }
  }

  void dispose() {
    _state$.close();
  }

  void setHoldCount(int count) {
    if (count == _state.holdCount) {
      return;
    }

    List<Hold> _holds;
    if (count < _state.holdCount) {
      _holds = _state.holds.take(count);
    }
    if (count > _state.holdCount) {
      final Hold defaultHold = _state.holds[0];
      final int difference = count - _state.holdCount;
      _holds = [
        ..._state.holds,
        ...List.generate(difference, (i) => defaultHold)
      ];
    }
    _state$.add(_state.copyWith(holdCount: count, holds: _holds));
  }

  void setSets(int sets) {
    _state$.add(_state.copyWith(sets: sets));
  }

  void setRestBetweenHolds(int s) {
    _state$.add(_state.copyWith(restBetweenHolds: s));
  }

  void setRestBetweenSets(int s) {
    _state$.add(_state.copyWith(restBetweenSets: s));
  }

  void setBoard(Board board) {
    _state$.add(_state.copyWith(board: board));
  }

  void setHolds(List<Hold> holds) {
    _state$.add(_state.copyWith(holds: holds));
  }

  void setLabel(Label label) {
    _state$.add(_state.copyWith(label: label));
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
          holds == other.holds &&
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
}
