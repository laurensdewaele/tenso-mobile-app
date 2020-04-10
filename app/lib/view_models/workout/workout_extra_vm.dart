import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:app/models/models.dart';
import 'package:app/services/keyboard.dart';
import 'package:app/services/parser.dart';
import 'package:app/services/validation.dart';
import 'package:app/view_models/workout/workout_navigator.dart';
import 'package:app/view_models/workout/workout_vm.dart';

class WorkoutExtraViewModel {
  KeyboardService _keyboardService;
  WorkoutNavigator _workoutNavigator;
  WorkoutViewModel _workoutViewModel;
  StreamSubscription _keyboardSub;
  StreamSubscription _navigatorSub;
  StreamSubscription _workoutVMSub;

  WorkoutExtraViewModel({
    @required WorkoutViewModel workoutViewModel,
    @required WorkoutNavigator workoutNavigator,
    @required KeyboardService keyboardService,
  }) {
    _keyboardService = keyboardService;
    _workoutViewModel = workoutViewModel;
    _workoutNavigator = workoutNavigator;
    _keyboardSub = _keyboardService.shouldValidate$.listen((_) => _validate());
    _workoutVMSub = _workoutViewModel.state$.listen(_setVariables);
    _navigatorSub =
        _workoutNavigator.shouldValidate$.listen((_) => _validateAndReport());
    _workoutTypesVariables = _workoutViewModel.workoutTypesVariables;
  }

  WorkoutTypesVariables _workoutTypesVariables;
  WorkoutTypesVariables get workoutTypesVariables => _workoutTypesVariables;

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
    _workoutVMSub.cancel();
    _navigatorSub.cancel();
    _keyboardSub.cancel();
  }
}
