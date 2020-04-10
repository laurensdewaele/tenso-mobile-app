import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:rxdart/rxdart.dart';

import 'package:app/data/grips.dart';
import 'package:app/models/models.dart';
import 'package:app/services/parser.dart';
import 'package:app/services/validation.dart';
import 'package:app/view_models/workout/hold_page_vm_state.dart';
import 'package:app/view_models/workout/workout_navigator.dart';
import 'package:app/view_models/workout/workout_navigator_state.dart';
import 'package:app/view_models/workout/workout_vm.dart';
import 'package:app/view_models/workout/workout_vm_state.dart';

class HoldPageViewModel {
  WorkoutNavigator _workoutNavigator;
  WorkoutViewModel _workoutViewModel;
  Stream<int> _currentHoldIndex$;
  StreamSubscription _sub1;
  StreamSubscription _sub2;
  StreamSubscription _sub3;
  StreamSubscription _sub4;

  BehaviorSubject<HoldPageInitialState> _initialState$ =
      BehaviorSubject.seeded(null);
  Stream<HoldPageInitialState> get initialState$ => _initialState$.stream;

  HoldPageInternalState _internalState;

  HoldPageViewModel({
    @required WorkoutViewModel workoutViewModel,
    @required WorkoutNavigator workoutNavigator,
  }) {
    _workoutViewModel = workoutViewModel;
    _workoutNavigator = workoutNavigator;

    _currentHoldIndex$ = _workoutNavigator.activePage$
        .map((page) => page.holdIndex)
        .where((int holdIndex) => holdIndex != null)
        .distinct();

    _sub1 = _workoutViewModel.shouldValidate$.listen((_) {
      _validate();
    });
    _sub2 =
        _workoutNavigator.shouldValidate$.listen((_) => _validateAndReport());
    _sub3 = _currentHoldIndex$.listen((int holdIndex) {
      _sub4 =
          _workoutViewModel.state$.listen((WorkoutViewModelState workoutState) {
        _setInitialState(workoutState, holdIndex);
        _setInternalState(workoutState, holdIndex);
      });
    });
  }

  void _setInitialState(WorkoutViewModelState workoutState, holdIndex) {
    _initialState$.add(
      HoldPageInitialState(
          primaryColor: workoutState.primaryColor,
          inputsEnabled: workoutState.inputsEnabled,
          handHold: workoutState.holds[holdIndex].handHold,
          leftGrip: workoutState.holds[holdIndex].leftGrip,
          rightGrip: workoutState.holds[holdIndex].rightGrip,
          leftGripBoardHold: workoutState.holds[holdIndex].leftGripBoardHold,
          rightGripBoardHold: workoutState.holds[holdIndex].rightGripBoardHold,
          repetitions: workoutState.holds[holdIndex].repetitions,
          restBetweenRepetitions:
              workoutState.holds[holdIndex].restBetweenRepetitions,
          hangTime: workoutState.holds[holdIndex].hangTime,
          addedWeight: workoutState.holds[holdIndex].addedWeight,
          board: workoutState.board,
          currentHold: holdIndex + 1,
          totalHolds: workoutState.holds.length,
          weightUnitDescription:
              workoutState.weightUnit == WeightUnit.metric ? 'kg' : 'lbs',
          textPrimaryColor: workoutState.textPrimaryColor),
    );
  }

  void _setInternalState(WorkoutViewModelState workoutState, holdIndex) {
    _internalState = HoldPageInternalState(
        currentHoldIndex: holdIndex,
        handHold: workoutState.holds[holdIndex].handHold,
        leftGrip: workoutState.holds[holdIndex].leftGrip,
        rightGrip: workoutState.holds[holdIndex].rightGrip,
        leftGripBoardHold: workoutState.holds[holdIndex].leftGripBoardHold,
        rightGripBoardHold: workoutState.holds[holdIndex].rightGripBoardHold,
        repetitions: workoutState.holds[holdIndex].repetitions,
        restBetweenRepetitions:
            workoutState.holds[holdIndex].restBetweenRepetitions,
        hangTime: workoutState.holds[holdIndex].hangTime,
        addedWeight: workoutState.holds[holdIndex].addedWeight,
        repetitionsInput: workoutState.holds[holdIndex].repetitions.toString(),
        restBetweenRepetitionsInput:
            workoutState.holds[holdIndex].restBetweenRepetitions.toString(),
        hangTimeInput: workoutState.holds[holdIndex].hangTime.toString(),
        addedWeightInput: workoutState.holds[holdIndex].addedWeight.toString(),
        board: workoutState.board);
  }

  void _validateAndReport() {
    if (_validate() == true) {
      _workoutViewModel.setHoldVariables(
          leftGrip: _internalState.leftGrip,
          rightGrip: _internalState.rightGrip,
          leftGripBoardHold: _internalState.leftGripBoardHold,
          rightGripBoardHold: _internalState.rightGripBoardHold,
          repetitions: _internalState.repetitions,
          hangTime: _internalState.hangTime,
          restBetweenRepetitions: _internalState.restBetweenRepetitions,
          addedWeight: _internalState.addedWeight,
          handHold: _internalState.handHold,
          holdIndex: _internalState.currentHoldIndex);
      _workoutNavigator.handleValidationSuccess();
    }
  }

  bool _validate() {
    final _repetitions =
        InputParsers.parseToInt(_internalState.repetitionsInput);
    final _restBetweenRepetitions =
        InputParsers.parseToInt(_internalState.restBetweenRepetitionsInput);
    final _hangTime = InputParsers.parseToInt(_internalState.hangTimeInput);
    final _addedWeight =
        InputParsers.parseToDouble(_internalState.addedWeightInput);

    final List<bool> _validations = [];
    _validations.add(Validators.biggerThanZero<int>(_repetitions));
    _validations.add(Validators.biggerThanZero<int>(_restBetweenRepetitions));
    _validations.add(Validators.biggerThanZero<int>(_hangTime));
    _validations.add(Validators.biggerThanZero<double>(_addedWeight));

    return _validations.fold(true, (a, b) => a && b);
  }

  void setLeftGrip(Grip grip) {
    _internalState = _internalState.copyWith(leftGrip: grip);
  }

  void setRightGrip(Grip grip) {
    _internalState = _internalState.copyWith(rightGrip: grip);
  }

  void setHandHold(HandHold handHold) {
    _internalState = _internalState.copyWith(handHold: handHold);
  }

  void setLeftGripBoardHold(BoardHold boardHold) {
    _internalState = _internalState.copyWith(leftGripBoardHold: boardHold);
  }

  void setRightGripBoardHold(BoardHold boardHold) {
    _internalState = _internalState.copyWith(rightGripBoardHold: boardHold);
  }

  void setRepetitions(String s) {
    _internalState = _internalState.copyWith(repetitionsInput: s);
  }

  void setRestBetweenRepetitions(String s) {
    _internalState = _internalState.copyWith(restBetweenRepetitionsInput: s);
  }

  void setHangTime(String s) {
    _internalState = _internalState.copyWith(hangTimeInput: s);
  }

  void setAddedWeight(String s) {
    _internalState = _internalState.copyWith(addedWeightInput: s);
  }

  void handleLeftHandSelected(HandHold handHold) {
    if (handHold == HandHold.oneHandedLeft && _internalState.leftGrip == null) {
      setLeftGrip(Grips.openHandL);
      setLeftGripBoardHold(_internalState.board.defaultLeftGripHold);
    }
    if (handHold == HandHold.oneHandedLeft) {
      setRightGrip(null);
      setRightGripBoardHold(null);
    }
    setHandHold(handHold);
  }

  void handleRightHandSelected(HandHold handHold) {
    if (handHold == HandHold.oneHandedRight &&
        _internalState.rightGrip == null) {
      setRightGrip(Grips.openHandR);
      setRightGripBoardHold(_internalState.board.defaultRightGripHold);
    }

    if (handHold == HandHold.oneHandedRight) {
      setLeftGrip(null);
      setLeftGripBoardHold(null);
    }
    setHandHold(handHold);
  }

  void handleOneHandedTap(HandHold handHold) {
    if (handHold == HandHold.oneHandedRight) {
      setLeftGrip(null);
      setLeftGripBoardHold(null);
    }
    if (handHold == HandHold.oneHandedLeft) {
      setRightGrip(null);
      setRightGripBoardHold(null);
    }
    setHandHold(handHold);
  }

  void handleTwoHandedTap(HandHold handHold) {
    final BoardHold defaultLeftGripBoardHold =
        _internalState.board.defaultLeftGripHold;
    final BoardHold defaultRightGripBoardHold =
        _internalState.board.defaultRightGripHold;

    if (_internalState.leftGrip == null) {
      final existingPosition = _internalState.rightGripBoardHold.position;
      if (existingPosition != defaultLeftGripBoardHold.position) {
        setLeftGripBoardHold(defaultLeftGripBoardHold);
      } else {
        final _boardHolds = _internalState.board.boardHolds.toList();
        // TODO: Figure out if I need recursiveness on different boards
        final newBoardHoldPosition = _boardHolds.firstWhere(
                (BoardHold boardHold) =>
                    boardHold.position ==
                    defaultLeftGripBoardHold.position - 1) ??
            _boardHolds.firstWhere((BoardHold boardHold) =>
                boardHold.position == defaultLeftGripBoardHold.position + 1);
        setLeftGripBoardHold(newBoardHoldPosition);
      }
      setLeftGrip(Grips.openHandL);
    }

    if (_internalState.rightGrip == null) {
      final existingPosition = _internalState.leftGripBoardHold.position;

      if (existingPosition != defaultRightGripBoardHold.position) {
        setRightGripBoardHold(defaultRightGripBoardHold);
      } else {
        final _boardHolds = _internalState.board.boardHolds.toList();
        // TODO: Figure out if I need recursiveness on different boards
        final BoardHold newBoardHoldPosition = _boardHolds.firstWhere(
                (BoardHold boardHold) =>
                    boardHold.position ==
                    defaultRightGripBoardHold.position + 1) ??
            _boardHolds.firstWhere((BoardHold boardHold) =>
                boardHold.position == defaultRightGripBoardHold.position - 1);
        setRightGripBoardHold(newBoardHoldPosition);
      }
      setRightGrip(Grips.openHandR);
    }
    setHandHold(handHold);
  }

  void handleRightGripSelected(Grip grip) {
    final BoardHold _rightGripBoardHold = _internalState.rightGripBoardHold;
    if (Validators.checkGripCompatibility(_rightGripBoardHold, grip) == true) {
      setRightGrip(grip);
    }
  }

  void handleLeftGripSelected(Grip grip) {
    final BoardHold _leftGripBoardHold = _internalState.leftGripBoardHold;
    if (Validators.checkGripCompatibility(_leftGripBoardHold, grip) == true) {
      setLeftGrip(grip);
    }
  }

  void dispose() {
    _initialState$.close();
    _sub1.cancel();
    _sub2.cancel();
    _sub3.cancel();
    _sub4.cancel();
  }
}
