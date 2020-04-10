import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:app/models/models.dart';
import 'package:app/services/parser.dart';
import 'package:app/services/validation.dart';
import 'package:app/view_models/workout/workout_navigator.dart';
import 'package:app/view_models/workout/workout_vm.dart';
import 'package:app/view_models/workout/workout_vm_state.dart';

class WorkoutExtraViewModel {
  WorkoutNavigator _workoutNavigator;
  WorkoutViewModel _workoutViewModel;
  StreamSubscription _sub1;
  StreamSubscription _sub2;
  StreamSubscription _sub3;

  WorkoutExtraViewModel({
    @required WorkoutViewModel workoutViewModel,
    @required WorkoutNavigator workoutNavigator,
  }) {
    _workoutViewModel = workoutViewModel;
    _workoutNavigator = workoutNavigator;
    _sub1 = _workoutViewModel.shouldValidate$.listen((_) {
      _validate();
    });
    _sub2 = _workoutViewModel.state$.listen(_setVariables);
    _sub3 =
        _workoutNavigator.shouldValidate$.listen((_) => _validateAndReport());
  }

  Label _label;
  Label get label => _label;
  String _name;
  String get name => _name;

  String _nameInput;

  void _validateAndReport() {
    if (_validate() == true) {
      _workoutViewModel.setExtraVariables(label: _label, name: _name);
      _workoutNavigator.handleValidationSuccess();
    }
  }

  bool _validate() {
    _name = InputParsers.parseString(_nameInput);

    final List<bool> _validations = [];
    _validations.add(Validations.stringNotEmpty(_name));

    return _validations.fold(true, (a, b) => a && b);
  }

  void setLabel(Label label) {
    _label = label;
  }

  void setName(String s) {
    _nameInput = s;
  }

  void _setVariables(WorkoutViewModelState state) {
    _label = state.label;
    _name = state.name;
  }

  void dispose() {
    _sub1.cancel();
    _sub2.cancel();
    _sub3.cancel();
  }
}
