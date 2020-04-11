import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:app/models/models.dart';
import 'package:app/services/parser.dart';
import 'package:app/services/validation.dart';
import 'package:app/view_models/workout/extra_page_vm_state.dart';
import 'package:app/view_models/workout/workout_navigator.dart';
import 'package:app/view_models/workout/workout_vm.dart';

class ExtraPageViewModel {
  WorkoutNavigator _workoutNavigator;
  WorkoutViewModel _workoutViewModel;
  StreamSubscription _sub1;
  StreamSubscription _sub2;

  ExtraPageState _state;
  ExtraPageState get state => _state;

  ExtraPageViewModel({
    @required WorkoutViewModel workoutViewModel,
    @required WorkoutNavigator workoutNavigator,
  }) {
    _workoutViewModel = workoutViewModel;
    _workoutNavigator = workoutNavigator;
    _setInitialState();
    _sub1 = _workoutViewModel.shouldValidate$.listen((_) {
      _validate();
    });
    _sub2 =
        _workoutNavigator.shouldValidate$.listen((_) => _validateAndReport());
  }

  void handleForwardRequest() {
    _workoutNavigator.handleForwardRequest();
  }

  void _setInitialState() {
    _state = ExtraPageState(
        label: _workoutViewModel.state.label,
        name: _workoutViewModel.state.name,
        nameInput: _workoutViewModel.state.name,
        inputsEnabled: _workoutViewModel.state.inputsEnabled,
        primaryColor: _workoutViewModel.state.primaryColor,
        extraTabButtonText: _workoutViewModel.state.extraTabButtonText);
  }

  void _validateAndReport() {
    if (_validate() == true) {
      _workoutViewModel.setExtraVariables(
          label: _state.label, name: _state.name);
      _workoutNavigator.handleValidationSuccess();
    }
  }

  bool _validate() {
    final _name = InputParsers.parseString(string: _state.nameInput);
    _state = _state.copyWith(name: _name);
    return Validators.stringNotEmpty(string: _name, inputField: 'Name');
  }

  void setLabel(Label label) {
    _state = _state.copyWith(label: label);
  }

  void setName(String s) {
    _state = _state.copyWith(nameInput: s);
  }

  void dispose() {
    _sub1.cancel();
    _sub2.cancel();
  }
}
