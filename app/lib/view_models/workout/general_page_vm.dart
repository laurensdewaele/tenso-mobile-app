import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:rxdart/rxdart.dart';

import 'package:app/models/models.dart';
import 'package:app/services/parser.dart';
import 'package:app/services/validation.dart';
import 'package:app/view_models/workout/general_page_vm_state.dart';
import 'package:app/view_models/workout/workout_navigator.dart';
import 'package:app/view_models/workout/workout_vm.dart';
import 'package:app/view_models/workout/workout_vm_state.dart';

class GeneralPageViewModel {
  WorkoutNavigator _workoutNavigator;
  WorkoutViewModel _workoutViewModel;
  StreamSubscription _sub1;
  StreamSubscription _sub2;
  StreamSubscription _sub3;

  GeneralPageViewModel({
    @required WorkoutViewModel workoutViewModel,
    @required WorkoutNavigator workoutNavigator,
  }) {
    _workoutViewModel = workoutViewModel;
    _workoutNavigator = workoutNavigator;
    _sub1 = _workoutViewModel.shouldValidate$.listen((_) {
      _validate();
    });
    _sub2 = _workoutViewModel.state$.listen(_setVariables);
    _sub3 = _workoutNavigator.shouldValidate$.listen((_) {
      _validateAndReport();
    });
  }

  BehaviorSubject<GeneralPageInitialState> _initialState$ =
      BehaviorSubject.seeded(null);
  Stream<GeneralPageInitialState> get initialState$ => _initialState$.stream;

  GeneralPageInternalState _internalState;

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
    _validations.add(Validations.biggerThanZero<int>(_holdCount));
    _validations.add(Validations.biggerThanZero<int>(_sets));
    _validations.add(Validations.biggerThanZero<int>(_restBetweenHolds));
    _validations.add(Validations.biggerThanZero<int>(_restBetweenSets));

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

  void _setVariables(WorkoutViewModelState workoutVMState) {
    _internalState = GeneralPageInternalState(
      holdCount: null,
      sets: null,
      restBetweenHolds: null,
      restBetweenSets: null,
      board: workoutVMState.board,
      holdCountInput: workoutVMState.holdCount.toString(),
      setsInput: workoutVMState.sets.toString(),
      restBetweenHoldsInput: workoutVMState.restBetweenHolds.toString(),
      restBetweenSetsInput: workoutVMState.restBetweenSets.toString(),
    );
    _initialState$.add(GeneralPageInitialState(
        inputsEnabled: workoutVMState.inputsEnabled,
        primaryColor: workoutVMState.primaryColor,
        holdCount: workoutVMState.holdCount,
        sets: workoutVMState.sets,
        restBetweenHolds: workoutVMState.restBetweenHolds,
        restBetweenSets: workoutVMState.restBetweenSets,
        board: workoutVMState.board));
  }

  void dispose() {
    _initialState$.close();
    _sub1.cancel();
    _sub2.cancel();
    _sub3.cancel();
  }
}
