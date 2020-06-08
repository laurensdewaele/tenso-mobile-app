import 'package:app/models/models.dart';
import 'package:app/services/error.service.dart';
import 'package:app/services/navigation.service.dart';
import 'package:app/services/parser.service.dart';
import 'package:app/services/toast.service.dart';
import 'package:app/services/validation.service.dart';
import 'package:app/state/settings.state.dart';
import 'package:app/state/workouts.state.dart';
import 'package:app/view_models/workout/workout.vm.dart';
import 'package:app/view_models/workout/workout_state_2.vm.dart';
import 'package:flutter/foundation.dart';

class WorkoutViewModel2 extends ChangeNotifier {
  Workout _workout;
  WorkoutTypes _workoutType;
  WorkoutsState _workoutsState;
  ToastService _toastService;
  NavigationService _navigationService;

  WorkoutViewModelState2 _state;
  WorkoutViewModelState2 get state => _state;

  WorkoutViewModel2(
      {@required WorkoutTypes workoutType, @required Workout workout}) {
    _workout = workout;
    _workoutsState = WorkoutsState();
    _workoutType = workoutType;
    _toastService = ToastService();
    _navigationService = NavigationService();

    final _weightSystem = SettingsState().settings.weightSystem;

    WorkoutViewModelState2 _initialState;
    switch (_workoutType) {
      case WorkoutTypes.newWorkout:
        _initialState =
            WorkoutViewModelState2.addWorkout(workout, _weightSystem);
        break;
      case WorkoutTypes.editWorkout:
        _initialState =
            WorkoutViewModelState2.editWorkout(workout, _weightSystem);
        break;
      case WorkoutTypes.viewWorkout:
        _initialState =
            WorkoutViewModelState2.viewWorkout(workout, workout.weightSystem);
        break;
    }
    _state = _initialState;
  }

  void addGroup(Group group) {}

  Future<bool> handleSaveTap() {
    return Future.sync(() {
      final bool _isValid = _validate();
      if (_isValid == true) {
        // TODO: Save workout
        _navigationService.pop();
      }
      return _isValid;
    });
  }

  void setRestBetweenGroupsFixed() {
    _state = state.copyWith(restBetweenGroupsFixed: true);
    notifyListeners();
  }

  void setRestBetweenGroupsVariable() {
    _state = state.copyWith(
        restBetweenGroupsFixed: false,
        restBetweenGroupsSInput: null,
        restBetweenGroupsS: null);
    notifyListeners();
  }

  void setRestBetweenGroupsS(String restBetweenGroupsS) {
    _state = state.copyWith(restBetweenGroupsSInput: restBetweenGroupsS);
  }

  void setLabel(Label label) {
    _state = state.copyWith(label: label);
  }

  void setName(String nameInput) {
    _state = state.copyWith(nameInput: nameInput);
  }

  void setWorkout() async {
    Workout _newWorkout = _workout.rebuild((b) => b
      ..label = state.label
      ..sets = state.sets
      ..groups.replace(state.groups)
      ..name = state.name
      ..weightSystem = state.weightSystem);

    switch (_workoutType) {
      case WorkoutTypes.newWorkout:
        _workoutsState.addWorkout(_newWorkout);
        break;
      case WorkoutTypes.editWorkout:
        _workoutsState.editWorkout(_newWorkout);
        break;
      case WorkoutTypes.viewWorkout:
        break;
    }
  }

  bool _validate() {
    bool _isNameValid = false;
    bool _isRestBetweenGroupsSValid = false;
    bool _isGroupsValid = false;

    if (state.restBetweenGroupsFixed == true) {
      final int _restBetweenGroupsS = InputParsers.parseToInt(
          string: state.restBetweenGroupsSInput,
          inputField: 'Rest between groups');
      _state = state.copyWith(restBetweenGroupsS: _restBetweenGroupsS);
      _isRestBetweenGroupsSValid = Validators.biggerThanZero(
          value: _restBetweenGroupsS, inputField: 'Rest between groups');
    } else {
      _isRestBetweenGroupsSValid = true;
    }

    final String _name = InputParsers.parseString(string: state.nameInput);
    _state = state.copyWith(name: _name);
    _isNameValid = Validators.stringNotEmpty(string: _name, inputField: 'Name');

    _isGroupsValid = state.groups.length > 0;
    if (_isGroupsValid == false) {
      _toastService.add(ErrorMessages.groupsEmpty());
    }

    return [_isNameValid, _isRestBetweenGroupsSValid, _isGroupsValid]
        .fold(true, (a, b) => a && b);
  }

  void dispose() {
    super.dispose();
  }
}
