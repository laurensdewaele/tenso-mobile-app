import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:app/models/models.dart';
import 'package:app/services/parser.dart';
import 'package:app/services/validation.dart';
import 'package:app/view_models/workout/workout_navigator.dart';
import 'package:app/view_models/workout/workout_vm.dart';

class GeneralWorkoutViewModel {
  WorkoutViewModel _workoutViewModel;
  WorkoutNavigator _workoutNavigator;
  StreamSubscription _workoutVMSub;
  StreamSubscription _navigatorSub;

  GeneralWorkoutViewModel({
    @required WorkoutViewModel workoutViewModel,
    @required WorkoutNavigator workoutNavigator,
  }) {
    _workoutViewModel = workoutViewModel;
    _workoutNavigator = workoutNavigator;
    _workoutVMSub = _workoutViewModel.state$.listen(_setVariables);
    _navigatorSub =
        _workoutNavigator.shouldValidate$.listen((_) => _validateAndReport());
  }

  int _holdCount;
  int get holdCount => _holdCount;
  int _sets;
  int get sets => sets;
  int _restBetweenHolds;
  int get restBetweenHolds => _restBetweenHolds;
  int _restBetweenSets;
  int get restBetweenSets => restBetweenSets;
  Board _board;
  Board get board => _board;

  String _holdCountInput;
  String _setsInput;
  String _restBetweenHoldsInput;
  String _restBetweenSetsInput;

  void _validateAndReport() {
    if (_validate() == true) {
      _workoutViewModel.setHoldCount(_holdCount);
      _workoutViewModel.setSets(_sets);
      _workoutViewModel.setRestBetweenHolds(_restBetweenHolds);
      _workoutViewModel.setRestBetweenSets(_restBetweenSets);
      _workoutViewModel.setBoard(_board);
      _workoutNavigator.handleValidationSuccess();
    }
  }

  bool _validate() {
    _holdCount = InputParsers.parseToInt(_holdCountInput);
    _sets = InputParsers.parseToInt(_setsInput);
    _restBetweenHolds = InputParsers.parseToInt(_restBetweenHoldsInput);
    _restBetweenSets = InputParsers.parseToInt(_restBetweenSetsInput);

    final List<bool> _validations = [];
    _validations.add(Validations.biggerThanZero<int>(_holdCount));
    _validations.add(Validations.biggerThanZero<int>(_sets));
    _validations.add(Validations.biggerThanZero<int>(_restBetweenHolds));
    _validations.add(Validations.biggerThanZero<int>(_restBetweenSets));

    return _validations.fold(true, (a, b) => a && b);
  }

  void setHoldCount(String s) {
    _holdCountInput = s;
  }

  void setSets(String s) {
    _setsInput = s;
  }

  void setRestBetweenHolds(String s) {
    _restBetweenHoldsInput = s;
  }

  void setRestBetweenSets(String s) {
    _restBetweenSetsInput = s;
  }

  void _setVariables(WorkoutViewModelState state) {
    _holdCount = state.holdCount;
    _sets = state.sets;
    _restBetweenHolds = state.restBetweenHolds;
    _restBetweenSets = state.restBetweenSets;
    _board = state.board;
  }

  void dispose() {
    _workoutVMSub.cancel();
    _navigatorSub.cancel();
  }
}
