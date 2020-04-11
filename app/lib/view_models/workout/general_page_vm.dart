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

  GeneralPageViewModel({
    @required WorkoutViewModel workoutViewModel,
    @required WorkoutNavigator workoutNavigator,
  }) {
    _workoutViewModel = workoutViewModel;
    _workoutNavigator = workoutNavigator;
    _setInitialState();
    _holdCount$ = BehaviorSubject.seeded(_workoutViewModel.state.holdCount);
    _sub1 = _workoutViewModel.shouldValidate$.listen((_) {
      _validate();
    });
    _sub2 = _workoutNavigator.shouldValidate$.listen((_) {
      _validateAndReport();
    });
  }

  void _setInitialState() {
    _state = GeneralPageState(
      inputsEnabled: _workoutViewModel.state.inputsEnabled,
      primaryColor: _workoutViewModel.state.primaryColor,
      holdCount: _workoutViewModel.state.holdCount,
      sets: _workoutViewModel.state.sets,
      restBetweenHolds: _workoutViewModel.state.restBetweenHolds,
      restBetweenSets: _workoutViewModel.state.restBetweenSets,
      board: _workoutViewModel.state.board,
      holdCountInput: _workoutViewModel.state.holdCount.toString(),
      setsInput: _workoutViewModel.state.sets.toString(),
      restBetweenHoldsInput:
          _workoutViewModel.state.restBetweenHolds.toString(),
      restBetweenSetsInput: _workoutViewModel.state.restBetweenSets.toString(),
    );
  }

  void _validateAndReport() {
    if (_validate() == true) {
      _workoutViewModel.setGeneralVariables(
          holdCount: _state.holdCount,
          sets: _state.sets,
          restBetweenHolds: _state.restBetweenHolds,
          restBetweenSets: _state.restBetweenSets,
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
    final _restBetweenHolds = InputParsers.parseToInt(
        string: _state.restBetweenHoldsInput, inputField: 'Rest between holds');
    final _restBetweenSets = InputParsers.parseToInt(
        string: _state.restBetweenSetsInput, inputField: 'Rest between sets');

    _state = _state.copyWith(
        holdCount: _holdCount,
        sets: _sets,
        restBetweenHolds: _restBetweenHolds,
        restBetweenSets: _restBetweenSets);

    final bool _isHoldInputValid =
        Validators.biggerThanZero<int>(value: _holdCount, inputField: 'Holds');
    final bool _isSetsInputValid =
        Validators.biggerThanZero<int>(value: _sets, inputField: 'Sets');
    final bool _isRestBetweenHoldsInputValid = Validators.biggerThanZero<int>(
        value: _restBetweenHolds, inputField: 'Rest between holds');
    final bool _isRestBetweenSetsValid = Validators.biggerThanZero<int>(
        value: _restBetweenSets, inputField: 'Rest between sets');

    if (_isHoldInputValid == true) {
      _holdCount$.add(_holdCount);
    }

    return [
      _isHoldInputValid,
      _isSetsInputValid,
      _isRestBetweenHoldsInputValid,
      _isRestBetweenSetsValid
    ].fold(true, (a, b) => a && b);
  }

  void setHoldCount(String s) {
    _state = _state.copyWith(holdCountInput: s);
  }

  void setSets(String s) {
    _state = _state.copyWith(setsInput: s);
  }

  void setRestBetweenHolds(String s) {
    _state = _state.copyWith(restBetweenHoldsInput: s);
  }

  void setRestBetweenSets(String s) {
    _state = _state.copyWith(restBetweenSetsInput: s);
  }

  void setBoard(Board board) {
    _state = _state.copyWith(board: board);
  }

  void dispose() {
    _holdCount$.close();
    _sub1.cancel();
    _sub2.cancel();
  }
}
