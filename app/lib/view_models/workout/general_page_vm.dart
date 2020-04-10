import 'dart:async';

import 'package:flutter/foundation.dart';

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

  GeneralPageInitialState _initialState;
  GeneralPageInitialState get initialState => _initialState;
  GeneralPageInternalState _internalState;

  GeneralPageViewModel({
    @required WorkoutViewModel workoutViewModel,
    @required WorkoutNavigator workoutNavigator,
  }) {
    _workoutViewModel = workoutViewModel;
    _workoutNavigator = workoutNavigator;
    _setInitialState();
    _sub1 = _workoutViewModel.shouldValidate$.listen((_) {
      _validate();
    });
    _sub2 = _workoutNavigator.shouldValidate$.listen((_) {
      _validateAndReport();
    });
  }

  void _setInitialState() {
    final _state = _workoutViewModel.state;
    _initialState = GeneralPageInitialState(
        inputsEnabled: _state.inputsEnabled,
        primaryColor: _state.primaryColor,
        holdCount: _state.holdCount,
        sets: _state.sets,
        restBetweenHolds: _state.restBetweenHolds,
        restBetweenSets: _state.restBetweenSets,
        board: _state.board);
    _internalState = GeneralPageInternalState(
      holdCount: null,
      sets: null,
      restBetweenHolds: null,
      restBetweenSets: null,
      board: _state.board,
      holdCountInput: _state.holdCount.toString(),
      setsInput: _state.sets.toString(),
      restBetweenHoldsInput: _state.restBetweenHolds.toString(),
      restBetweenSetsInput: _state.restBetweenSets.toString(),
    );
  }

  void _validateAndReport() {
    if (_validate() == true) {
      _workoutViewModel.setGeneralVariables(
          holdCount: _internalState.holdCount,
          sets: _internalState.sets,
          restBetweenHolds: _internalState.restBetweenHolds,
          restBetweenSets: _internalState.restBetweenSets,
          board: _internalState.board);
      _workoutNavigator.buildPagesDueToHoldCount(_internalState.holdCount);
      _workoutNavigator.handleValidationSuccess();
    }
  }

  bool _validate() {
    final _holdCount = InputParsers.parseToInt(_internalState.holdCountInput);
    final _sets = InputParsers.parseToInt(_internalState.setsInput);
    final _restBetweenHolds =
        InputParsers.parseToInt(_internalState.restBetweenHoldsInput);
    final _restBetweenSets =
        InputParsers.parseToInt(_internalState.restBetweenSetsInput);

    _internalState = _internalState.copyWith(
        holdCount: _holdCount,
        sets: _sets,
        restBetweenHolds: _restBetweenHolds,
        restBetweenSets: _restBetweenSets);

    final List<bool> _validations = [];
    _validations.add(Validators.biggerThanZero<int>(_holdCount));
    _validations.add(Validators.biggerThanZero<int>(_sets));
    _validations.add(Validators.biggerThanZero<int>(_restBetweenHolds));
    _validations.add(Validators.biggerThanZero<int>(_restBetweenSets));

    return _validations.fold(true, (a, b) => a && b);
  }

  void setHoldCount(String s) {
    _internalState = _internalState.copyWith(holdCountInput: s);
  }

  void setSets(String s) {
    _internalState = _internalState.copyWith(setsInput: s);
  }

  void setRestBetweenHolds(String s) {
    _internalState = _internalState.copyWith(restBetweenHoldsInput: s);
  }

  void setRestBetweenSets(String s) {
    _internalState = _internalState.copyWith(restBetweenSetsInput: s);
  }

  void setBoard(Board board) {
    _internalState = _internalState.copyWith(board: board);
  }

  void dispose() {
    _sub1.cancel();
    _sub2.cancel();
  }
}
