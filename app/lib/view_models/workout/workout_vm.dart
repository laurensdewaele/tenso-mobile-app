import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:rxdart/rxdart.dart';

import 'package:app/models/models.dart';
import 'package:app/services/keyboard.dart';
import 'package:app/view_models/workout/workout_vm_state.dart';

enum WorkoutTypes { newWorkout, editWorkout, viewWorkout }

class WorkoutViewModel {
  BehaviorSubject<WorkoutViewModelState> _state$;
  WorkoutViewModelState get _state => _state$.value;
  Stream<WorkoutViewModelState> get state$ => _state$.stream;
  WorkoutViewModelState get initialState => _state$.value;
  Stream<bool> shouldValidate$;

  WorkoutViewModel({
    @required WorkoutTypes workoutType,
    @required Workout workout,
    @required WeightUnit currentWeightUnit,
    @required KeyboardService keyboardService,
    // TODO: App state => workoutState
  }) {
    shouldValidate$ = MergeStream<bool>(
            [keyboardService.shouldLoseFocus$, keyboardService.inputComplete$])
        .asBroadcastStream();

    WorkoutViewModelState _initialState;
    switch (workoutType) {
      case WorkoutTypes.newWorkout:
        _initialState =
            WorkoutViewModelState.addWorkout(workout, currentWeightUnit);
        break;
      case WorkoutTypes.editWorkout:
        _initialState =
            WorkoutViewModelState.editWorkout(workout, currentWeightUnit);
        break;
      case WorkoutTypes.viewWorkout:
        _initialState =
            WorkoutViewModelState.viewWorkout(workout, currentWeightUnit);
        break;
    }
    _state$ = BehaviorSubject.seeded(_initialState);
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
