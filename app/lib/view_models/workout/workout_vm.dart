import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:built_collection/built_collection.dart';
import 'package:rxdart/rxdart.dart';

import 'package:app/data/basic_workout.dart';
import 'package:app/helpers/nullable.dart';
import 'package:app/models/models.dart';
import 'package:app/services/keyboard.dart';
import 'package:app/state/settings_state.dart';
import 'package:app/state/workouts_state.dart';
import 'package:app/view_models/workout/workout_vm_state.dart';

enum WorkoutTypes { newWorkout, editWorkout, viewWorkout }

class WorkoutViewModel {
  BehaviorSubject<WorkoutViewModelState> _state$;
  WorkoutViewModelState get state => _state$.value;
  Stream<WorkoutViewModelState> get state$ => _state$.stream;
  Stream<bool> shouldValidate$;
  WorkoutsState _workoutsState;
  KeyboardService _keyboardService;

  WorkoutTypes _workoutType;

  WorkoutViewModel(
      {@required WorkoutTypes workoutType, @required Workout workout}) {
    _workoutsState = WorkoutsState();
    _keyboardService = KeyboardService();
    _workoutType = workoutType;
    shouldValidate$ = MergeStream<bool>([
      _keyboardService.shouldLoseFocus$,
      _keyboardService.inputComplete$
    ]).asBroadcastStream();

    final _weightUnit = SettingsState().settings.weightUnit;

    WorkoutViewModelState _initialState;
    switch (_workoutType) {
      case WorkoutTypes.newWorkout:
        _initialState = WorkoutViewModelState.addWorkout(workout, _weightUnit);
        break;
      case WorkoutTypes.editWorkout:
        _initialState = WorkoutViewModelState.editWorkout(workout, _weightUnit);
        break;
      case WorkoutTypes.viewWorkout:
        _initialState =
            WorkoutViewModelState.viewWorkout(workout, workout.weightUnit);
        break;
    }
    _state$ = BehaviorSubject.seeded(_initialState);
  }

  void setWorkout() async {
    Workout _workout = Workout((b) => b
      ..stopwatchRestTimers = state.stopwatchRestTimers
      ..id = state.id
      ..label = state.label
      ..sets = state.sets
      ..holdCount = state.holdCount
      ..restBetweenHolds = state.restBetweenHolds
      ..restBetweenSets = state.restBetweenSets
      ..board = state.board.toBuilder()
      ..holds = state.holds.toBuiltList().toBuilder()
      ..name = state.name
      ..weightUnit = state.weightUnit);

    switch (_workoutType) {
      case WorkoutTypes.newWorkout:
        _workoutsState.addWorkout(_workout);
        break;
      case WorkoutTypes.editWorkout:
        _workoutsState.editWorkout(_workout);
        break;
      case WorkoutTypes.viewWorkout:
        break;
    }
  }

  void dispose() {
    _state$.close();
  }

  void setGeneralVariables(
      {@required int holdCount,
      @required int sets,
      @required bool stopwatchRestTimers,
      @required int restBetweenHolds,
      @required int restBetweenSets,
      @required Board board}) {
    _state$.add(state.copyWith(
        holdCount: holdCount,
        sets: sets,
        stopwatchRestTimers: stopwatchRestTimers,
        restBetweenHolds: Nullable(restBetweenHolds),
        restBetweenSets: Nullable(restBetweenSets),
        board: board,
        holds: _setRestSecondsBetweenReps(
            holds: _generateHoldsFromHoldCount(holdCount),
            stopwatchRestTimers: stopwatchRestTimers)));
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

      final List<Hold> _newHolds = []..addAll(state.holds);
      _newHolds[holdIndex] = _newHold;
      _state$.add(state.copyWith(holds: _newHolds));
    }
  }

  void setExtraVariables({@required Label label, @required String name}) {
    _state$.add(state.copyWith(label: label, name: name));
  }

  List<Hold> _generateHoldsFromHoldCount(int count) {
    if (count == state.holdCount) {
      return state.holds;
    }

    List<Hold> _holds;
    if (count < state.holdCount) {
      _holds = state.holds.take(count).toList();
    }
    if (count > state.holdCount) {
      final Hold defaultHold = state.holds[0];
      final int difference = count - state.holdCount;
      _holds = [
        ...state.holds,
        ...List.generate(difference, (i) => defaultHold)
      ];
    }
    return _holds;
  }

  List<Hold> _setRestSecondsBetweenReps(
      {List<Hold> holds, bool stopwatchRestTimers}) {
    List<Hold> _newHolds = []..addAll(holds);
    if (stopwatchRestTimers == true) {
      _newHolds = holds
          .map((h) => h.rebuild((b) => b..restBetweenRepetitions = null))
          .toList();
    }
    if (stopwatchRestTimers == false) {
      _newHolds = holds
          .map((h) => h.rebuild((b) => b
            ..restBetweenRepetitions =
                h.restBetweenRepetitions ?? basicRestTime))
          .toList();
    }
    return _newHolds;
  }
}
