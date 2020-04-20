import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:rxdart/rxdart.dart';

import 'package:app/models/models.dart';
import 'package:app/services/parser.dart';
import 'package:app/services/validation.dart';
import 'package:app/view_models/workout/general_page_vm_state.dart';
import 'package:app/view_models/workout/workout_navigator.dart';
import 'package:app/view_models/workout/workout_vm.dart';

class GeneralPageViewModel {
  WorkoutNavigator _workoutNavigator;
  WorkoutViewModel _workoutViewModel;
  StreamSubscription _sub1;
  StreamSubscription _sub2;

  GeneralPageState _state;
  GeneralPageState get state => _state;

  BehaviorSubject<int> _holdCount$;
  Stream<int> get holdCount$ => _holdCount$.stream;
  int get holdCount => _holdCount$.value;

  BehaviorSubject<bool> _countdownRestTimer$;
  Stream<bool> get countdownRestTimer$ => _countdownRestTimer$.stream;
  bool get countdownRestTimer => _countdownRestTimer$.value;

  GeneralPageViewModel({
    @required WorkoutViewModel workoutViewModel,
    @required WorkoutNavigator workoutNavigator,
  }) {
    _workoutViewModel = workoutViewModel;
    _workoutNavigator = workoutNavigator;
    _setInitialState();
    _holdCount$ = BehaviorSubject.seeded(_workoutViewModel.state.holdCount);
    _countdownRestTimer$ =
        BehaviorSubject.seeded(_workoutViewModel.state.countdownRestTimer);
    _sub1 = _workoutViewModel.shouldValidate$.listen((_) {
      _validate();
    });
    _sub2 = _workoutNavigator.shouldValidate$.listen((_) {
      _validateAndReport();
    });
  }

  void _setInitialState() {
    _state = GeneralPageState(
        countdownRestTimer: _workoutViewModel.state.countdownRestTimer,
        inputsEnabled: _workoutViewModel.state.inputsEnabled,
        primaryColor: _workoutViewModel.state.primaryColor,
        holdCount: _workoutViewModel.state.holdCount,
        sets: _workoutViewModel.state.sets,
        board: _workoutViewModel.state.board,
        holdCountInput: _workoutViewModel.state.holdCount.toString(),
        setsInput: _workoutViewModel.state.sets.toString(),
        textPrimaryColor: _workoutViewModel.state.textPrimaryColor);
  }

  void _validateAndReport() {
    if (_validate() == true) {
      _workoutViewModel.setGeneralVariables(
          holdCount: _state.holdCount,
          sets: _state.sets,
          countdownRestTimer: countdownRestTimer,
          board: _state.board);
      _workoutNavigator.buildPagesDueToHoldCount(_state.holdCount);
      _workoutNavigator.handleValidationSuccess();
    }
  }

  bool _validate() {
    final _holdCount = InputParsers.parseToInt(
        string: _state.holdCountInput, inputField: 'Holds');
    final _sets =
        InputParsers.parseToInt(string: _state.setsInput, inputField: 'Sets');

    _state = _state.copyWith(
      holdCount: _holdCount,
      sets: _sets,
    );

    final bool _isHoldInputValid =
        Validators.biggerThanZero<int>(value: _holdCount, inputField: 'Holds');
    final bool _isSetsInputValid =
        Validators.biggerThanZero<int>(value: _sets, inputField: 'Sets');

    if (_isHoldInputValid == true) {
      _holdCount$.add(_holdCount);
    }

    return [
      _isHoldInputValid,
      _isSetsInputValid,
    ].fold(true, (a, b) => a && b);
  }

  void setCountdownRestTimer({bool countdownRestTimer}) {
    _countdownRestTimer$.add(countdownRestTimer);
  }

  void setHoldCount(String s) {
    _state = _state.copyWith(holdCountInput: s);
  }

  void setSets(String s) {
    _state = _state.copyWith(setsInput: s);
  }

  void setBoard(Board board) {
    _state = _state.copyWith(board: board);
  }

  void dispose() {
    _holdCount$.close();
    _countdownRestTimer$.close();
    _sub1.cancel();
    _sub2.cancel();
  }
}
