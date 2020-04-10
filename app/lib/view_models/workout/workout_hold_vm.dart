import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:app/models/models.dart';
import 'package:app/services/parser.dart';
import 'package:app/services/validation.dart';
import 'package:app/view_models/workout/workout_navigator.dart';
import 'package:app/view_models/workout/workout_vm.dart';
import 'package:app/view_models/workout/workout_vm_state.dart';

class WorkoutHoldViewModel {
  WorkoutNavigator _workoutNavigator;
  WorkoutViewModel _workoutViewModel;
  WorkoutViewModelState _workoutVMState;
  Stream<int> _currentHoldIndex$;
  StreamSubscription _sub1;
  StreamSubscription _sub2;
  StreamSubscription _sub3;
  StreamSubscription _sub4;

  int _currentHoldIndex;

  WorkoutHoldViewModel({
    @required WorkoutViewModel workoutViewModel,
    @required WorkoutNavigator workoutNavigator,
  }) {
    _workoutViewModel = workoutViewModel;
    _workoutNavigator = workoutNavigator;

    _currentHoldIndex$ = _workoutNavigator.activePage$
        .map((NavigatorPage page) => page.holdIndex)
        .where((int holdIndex) => holdIndex != null)
        .distinct();

    _sub1 = _workoutViewModel.shouldValidate$.listen((_) {
      _validate();
    });
    _sub2 = _workoutViewModel.state$.listen((WorkoutViewModelState state) {
      _workoutVMState = state;
    });
    _sub3 =
        _workoutNavigator.shouldValidate$.listen((_) => _validateAndReport());
    _sub4 = _currentHoldIndex$.listen((int holdIndex) {
      _currentHoldIndex = holdIndex;
      _setVariables(holdIndex: holdIndex, workoutVMState: _workoutVMState);
    });
  }

  Grip _leftGrip;
  Grip get leftGrip => _leftGrip;
  Grip _rightGrip;
  Grip get rightGrip => _rightGrip;
  HandHold _handHold;
  HandHold get handHold => _handHold;
  BoardHold _leftGripBoardHold;
  BoardHold get leftGripBoardHold => _leftGripBoardHold;
  BoardHold _rightGripBoardHold;
  BoardHold get rightGripBoardHold => _rightGripBoardHold;

  int _repetitions;
  int get repetitions => _repetitions;
  int _restBetweenRepetitions;
  int get restBetweenRepetitions => _restBetweenRepetitions;
  int _hangTime;
  int get hangTime => _hangTime;
  double _addedWeight;
  double get addedWeight => _addedWeight;

  String _repetitionsInput;
  String _restBetweenRepetitionsInput;
  String _hangTimeInput;
  String _addedWeightInput;

  void _validateAndReport() {
    if (_validate() == true) {
      _workoutViewModel.setHoldVariables(
          leftGrip: leftGrip,
          rightGrip: rightGrip,
          leftGripBoardHold: leftGripBoardHold,
          rightGripBoardHold: rightGripBoardHold,
          repetitions: repetitions,
          hangTime: hangTime,
          restBetweenRepetitions: restBetweenRepetitions,
          addedWeight: addedWeight,
          handHold: handHold,
          holdIndex: _currentHoldIndex);
      _workoutNavigator.handleValidationSuccess();
    }
  }

  bool _validate() {
    _repetitions = InputParsers.parseToInt(_repetitionsInput);
    _restBetweenRepetitions =
        InputParsers.parseToInt(_restBetweenRepetitionsInput);
    _hangTime = InputParsers.parseToInt(_hangTimeInput);
    _addedWeight = InputParsers.parseToDouble(_addedWeightInput);

    final List<bool> _validations = [];
    _validations.add(Validations.biggerThanZero<int>(_repetitions));
    _validations.add(Validations.biggerThanZero<int>(_restBetweenRepetitions));
    _validations.add(Validations.biggerThanZero<int>(_hangTime));
    _validations.add(Validations.biggerThanZero<double>(_addedWeight));

    return _validations.fold(true, (a, b) => a && b);
  }

  void setLeftGrip(Grip grip) {
    _leftGrip = grip;
  }

  void setRightGrip(Grip grip) {
    _rightGrip = grip;
  }

  void setHandHold(HandHold handHold) {
    _handHold = handHold;
  }

  void setLeftGripBoardHold(BoardHold boardHold) {
    _leftGripBoardHold = boardHold;
  }

  void setRightGripBoardHold(BoardHold boardHold) {
    _rightGripBoardHold = boardHold;
  }

  void setRepetitions(String s) {
    _repetitionsInput = s;
  }

  void setRestBetweenRepetitions(String s) {
    _restBetweenRepetitionsInput = s;
  }

  void setHangTime(String s) {
    _hangTimeInput = s;
  }

  void setAddedWeight(String s) {
    _addedWeightInput = s;
  }

  void _setVariables({int holdIndex, WorkoutViewModelState workoutVMState}) {
    _leftGrip = workoutVMState?.holds[holdIndex]?.leftGrip ?? null;
    _rightGrip = workoutVMState?.holds[holdIndex]?.rightGrip ?? null;
    _handHold = workoutVMState?.holds[holdIndex]?.handHold;
    _leftGripBoardHold =
        workoutVMState?.holds[holdIndex]?.leftGripBoardHold ?? null;
    _rightGripBoardHold =
        workoutVMState?.holds[holdIndex]?.rightGripBoardHold ?? null;
    _repetitions = workoutVMState?.holds[holdIndex]?.repetitions;
    _restBetweenRepetitions =
        workoutVMState?.holds[holdIndex]?.restBetweenRepetitions;
    _hangTime = workoutVMState?.holds[holdIndex]?.hangTime;
    _addedWeight = workoutVMState?.holds[holdIndex]?.addedWeight;
  }

  void dispose() {
    _sub1.cancel();
    _sub2.cancel();
    _sub3.cancel();
    _sub4.cancel();
  }
}
