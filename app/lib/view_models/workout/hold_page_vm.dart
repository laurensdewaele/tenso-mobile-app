import 'dart:async';

import 'package:app/data/grips.dart';
import 'package:app/helpers/nullable.dart';
import 'package:app/models/models.dart';
import 'package:app/services/parser.dart';
import 'package:app/services/validation.dart';
import 'package:app/view_models/workout/hold_page_vm_state.dart';
import 'package:app/view_models/workout/workout_navigator.dart';
import 'package:app/view_models/workout/workout_vm.dart';
import 'package:app/view_models/workout/workout_vm_state.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class HoldPageViewModel {
  WorkoutNavigator _workoutNavigator;
  WorkoutViewModel _workoutViewModel;
  Stream<int> _currentHoldIndex$;
  StreamSubscription _sub1;
  StreamSubscription _sub2;
  StreamSubscription _sub3;
  StreamSubscription _sub4;

  BehaviorSubject<HoldPageState> _state$;
  Stream<HoldPageState> get state$ => _state$.stream;
  HoldPageState get initialState => _state$.value;

  HoldPageViewModel({
    @required WorkoutViewModel workoutViewModel,
    @required WorkoutNavigator workoutNavigator,
  }) {
    _workoutViewModel = workoutViewModel;
    _workoutNavigator = workoutNavigator;
    _state$ = BehaviorSubject.seeded(_buildState(
        _workoutViewModel.state, _workoutNavigator.activePage.holdIndex));

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
        if (!_state$.isClosed) {
          _state$.add(_buildState(workoutState, holdIndex));
        }
      });
    });
  }

  HoldPageState _buildState(WorkoutViewModelState workoutState, holdIndex) {
    return HoldPageState(
      countdownRestTimer: workoutState.countdownRestTimer,
      primaryColor: workoutState.primaryColor,
      inputsEnabled: workoutState.inputsEnabled,
      handHold: workoutState.holds[holdIndex].handHold,
      leftGrip: workoutState.holds[holdIndex].leftGrip,
      rightGrip: workoutState.holds[holdIndex].rightGrip,
      leftGripBoardHold: workoutState.holds[holdIndex].leftGripBoardHold,
      rightGripBoardHold: workoutState.holds[holdIndex].rightGripBoardHold,
      repetitions: workoutState.holds[holdIndex].repetitions,
      countdownRestDuration:
          workoutState.holds[holdIndex].countdownRestDuration,
      hangTime: workoutState.holds[holdIndex].hangTime,
      addedWeight: workoutState.holds[holdIndex].addedWeight,
      board: workoutState.board,
      currentHold: holdIndex + 1,
      totalHolds: workoutState.holds.length,
      weightUnitDescription:
          workoutState.weightUnit == WeightUnit.metric ? 'kg' : 'lbs',
      textPrimaryColor: workoutState.textPrimaryColor,
      currentHoldIndex: holdIndex,
      repetitionsInput: workoutState.holds[holdIndex].repetitions.toString(),
      countdownRestDurationInput:
          workoutState.holds[holdIndex].countdownRestDuration.toString(),
      hangTimeInput: workoutState.holds[holdIndex].hangTime.toString(),
      addedWeightInput: workoutState.holds[holdIndex].addedWeight.toString(),
    );
  }

  void _validateAndReport() {
    if (_validate() == true) {
      _workoutViewModel.setHoldVariables(
          leftGrip: _state$.value.leftGrip,
          rightGrip: _state$.value.rightGrip,
          leftGripBoardHold: _state$.value.leftGripBoardHold,
          rightGripBoardHold: _state$.value.rightGripBoardHold,
          repetitions: _state$.value.repetitions,
          hangTime: _state$.value.hangTime,
          countdownRestDuration: _state$.value.countdownRestDuration,
          addedWeight: _state$.value.addedWeight,
          handHold: _state$.value.handHold,
          holdIndex: _state$.value.currentHoldIndex);
      _workoutNavigator.handleValidationSuccess();
    }
  }

  bool _validate() {
    int _countdownRestDuration = _state$.value.countdownRestDuration;

    final _repetitions = InputParsers.parseToInt(
        string: _state$.value.repetitionsInput, inputField: 'Repetitions');
    if (initialState.countdownRestTimer == true) {
      _countdownRestDuration = InputParsers.parseToInt(
          string: _state$.value.countdownRestDurationInput,
          inputField: 'Rest between repetitions');
    }
    final _hangTime = InputParsers.parseToInt(
        string: _state$.value.hangTimeInput, inputField: 'Hang time');
    final _addedWeight = InputParsers.parseToDouble(
        string: _state$.value.addedWeightInput, inputField: 'Added weight');

    _state$.add(_state$.value.copyWith(
        repetitions: _repetitions,
        countdownRestDuration: Nullable(_countdownRestDuration),
        hangTime: _hangTime,
        addedWeight: _addedWeight));

    final List<bool> _validations = [];
    _validations.add(Validators.biggerThanZero<int>(
        value: _repetitions, inputField: 'Repetitions'));
    if (initialState.countdownRestTimer == true) {
      _validations.add(Validators.biggerThanZero<int>(
          value: _countdownRestDuration, inputField: 'Rest after hang'));
    }
    _validations.add(Validators.biggerThanZero<int>(
        value: _hangTime, inputField: 'Hang time'));
    _validations.add(_addedWeight != null);

    return _validations.fold(true, (a, b) => a && b);
  }

  void setLeftGrip(Grip grip) {
    _state$.add(_state$.value.copyWith(leftGrip: Nullable<Grip>(grip)));
  }

  void setRightGrip(Grip grip) {
    _state$.add(_state$.value.copyWith(rightGrip: Nullable<Grip>(grip)));
  }

  void setHandHold(HandHold handHold) {
    _state$.add(_state$.value.copyWith(handHold: handHold));
  }

  void setLeftGripBoardHold(BoardHold boardHold) {
    _state$.add(_state$.value
        .copyWith(leftGripBoardHold: Nullable<BoardHold>(boardHold)));
  }

  void setRightGripBoardHold(BoardHold boardHold) {
    _state$.add(_state$.value
        .copyWith(rightGripBoardHold: Nullable<BoardHold>(boardHold)));
  }

  void setRepetitions(String s) {
    _state$.add(_state$.value.copyWith(repetitionsInput: s));
  }

  void setCountdownRestDuration(String s) {
    _state$.add(_state$.value.copyWith(countdownRestDurationInput: s));
  }

  void setHangTime(String s) {
    _state$.add(_state$.value.copyWith(hangTimeInput: s));
  }

  void setAddedWeight(String s) {
    _state$.add(_state$.value.copyWith(addedWeightInput: s));
  }

  void handleLeftHandSelected(HandHold handHold) {
    if (handHold == HandHold.oneHandedLeft && _state$.value.leftGrip == null) {
      setLeftGrip(Grips.openHandL);
      setLeftGripBoardHold(_state$.value.board.defaultLeftGripHold);
    }
    if (handHold == HandHold.oneHandedLeft) {
      setRightGrip(null);
      setRightGripBoardHold(null);
    }
    setHandHold(handHold);
  }

  void handleRightHandSelected(HandHold handHold) {
    if (handHold == HandHold.oneHandedRight &&
        _state$.value.rightGrip == null) {
      setRightGrip(Grips.openHandR);
      setRightGripBoardHold(_state$.value.board.defaultRightGripHold);
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
        _state$.value.board.defaultLeftGripHold;
    final BoardHold defaultRightGripBoardHold =
        _state$.value.board.defaultRightGripHold;

    if (_state$.value.leftGrip == null) {
      final BoardHold _inUseBoardHold = _state$.value.rightGripBoardHold;
      BoardHold _boardHold;
      if (_inUseBoardHold != defaultLeftGripBoardHold) {
        _boardHold = defaultLeftGripBoardHold;
      } else {
        final _boardHolds = _state$.value.board.boardHolds.toList();
        _boardHold = _boardHolds
            .firstWhere((BoardHold boardHold) => boardHold != _inUseBoardHold);
      }
      setLeftGripBoardHold(_boardHold);
      setLeftGrip(
          Grips.matchSupportedFingersL(_boardHold.supportedFingers ?? 5));
    }

    if (_state$.value.rightGrip == null) {
      final BoardHold _inUseBoardHold = _state$.value.leftGripBoardHold;
      BoardHold _boardHold;
      if (_inUseBoardHold != defaultRightGripBoardHold) {
        _boardHold = defaultRightGripBoardHold;
      } else {
        final _boardHolds = _state$.value.board.boardHolds.toList();
        _boardHold = _boardHolds
            .firstWhere((BoardHold boardHold) => boardHold != _inUseBoardHold);
      }
      setRightGripBoardHold(_boardHold);
      setRightGrip(
          Grips.matchSupportedFingersR(_boardHold.supportedFingers ?? 5));
    }
    setHandHold(handHold);
  }

  void handleRightGripSelected(Grip grip) async {
    final BoardHold _rightGripBoardHold = _state$.value.rightGripBoardHold;
    if (Validators.checkGripCompatibility(
            boardHold: _rightGripBoardHold, grip: grip) ==
        true) {
      setRightGrip(grip);
    }
    return Future.value();
  }

  void handleLeftGripSelected(Grip grip) async {
    final BoardHold _leftGripBoardHold = _state$.value.leftGripBoardHold;
    if (Validators.checkGripCompatibility(
            boardHold: _leftGripBoardHold, grip: grip) ==
        true) {
      setLeftGrip(grip);
    }
    return Future.value();
  }

  void dispose() {
    _state$.close();
    _sub1.cancel();
    _sub2.cancel();
    _sub3.cancel();
    _sub4.cancel();
  }
}
