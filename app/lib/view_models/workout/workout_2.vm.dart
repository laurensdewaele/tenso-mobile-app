import 'package:app/data/basic_workout.data.dart';
import 'package:app/models/models.dart';
import 'package:app/routes/routes.dart';
import 'package:app/screens/group.screen.dart';
import 'package:app/services/error.service.dart';
import 'package:app/services/navigation.service.dart';
import 'package:app/services/parser.service.dart';
import 'package:app/services/toast.service.dart';
import 'package:app/services/validation.service.dart';
import 'package:app/state/settings.state.dart';
import 'package:app/state/workouts.state.dart';
import 'package:app/view_models/workout/group.vm.dart';
import 'package:app/view_models/workout/workout.vm.dart';
import 'package:app/view_models/workout/workout_state_2.vm.dart';
import 'package:flutter/foundation.dart';

class WorkoutViewModel2 extends ChangeNotifier {
  Workout _workout;
  WorkoutActions _workoutType;
  WorkoutActions get workoutAction => _workoutType;

  WorkoutViewModelState2 _state;
  WorkoutViewModelState2 get state => _state;

  NavigationService _navigationService;
  ToastService _toastService;
  SettingsState _settingsState;
  WorkoutsState _workoutsState;

  WorkoutViewModel2(
      {@required WorkoutActions workoutAction, @required Workout workout}) {
    _workout = workout;
    _workoutsState = WorkoutsState();
    _workoutType = workoutAction;
    _toastService = ToastService();
    _navigationService = NavigationService();
    _settingsState = SettingsState();

    final _weightSystem = _settingsState.settings.weightSystem;

    WorkoutViewModelState2 _initialState;
    switch (_workoutType) {
      case WorkoutActions.newWorkout:
        _initialState =
            WorkoutViewModelState2.addWorkout(workout, _weightSystem);
        break;
      case WorkoutActions.editWorkout:
        _initialState =
            WorkoutViewModelState2.editWorkout(workout, _weightSystem);
        break;
      case WorkoutActions.viewWorkout:
        _initialState =
            WorkoutViewModelState2.viewWorkout(workout, workout.weightSystem);
        break;
    }
    _state = _initialState;
  }

  void handleAddGroupTap() async {
    Group _group = basicGroup;
    if (state.groups.length > 0) {
      _group = state.groups[state.groups.length - 1];
    }

    _launchGroupScreenAndSetState(_group, GroupActions.addGroup);
  }

  void handleEditGroup(int groupIndex) {
    final Group _group = state.groups[groupIndex];
    _launchGroupScreenAndSetState(_group, GroupActions.editGroup, groupIndex);
  }

  void handleDeleteGroup(int groupIndex) {
    final List<Group> _newGroups = []..addAll(state.groups);
    _newGroups.removeAt(groupIndex);
    _state = state.copyWith(groups: _newGroups);
    notifyListeners();
  }

  void _launchGroupScreenAndSetState(Group group, GroupActions groupAction,
      [int editGroupIndex]) async {
    final _newGroup = await _navigationService.pushNamed(Routes.groupScreen,
        arguments: GroupScreenArguments(
            group: group,
            weightSystem: _settingsState.settings.weightSystem,
            groupAction: groupAction));

    if (_newGroup != null && groupAction == GroupActions.addGroup) {
      _state = state.copyWith(groups: state.groups..add((_newGroup as Group)));
      notifyListeners();
    }

    if (_newGroup != null &&
        groupAction == GroupActions.editGroup &&
        editGroupIndex != null) {
      final List<Group> _newGroups = []..addAll(state.groups);
      _newGroups[editGroupIndex] = _newGroup;
      _state = state.copyWith(groups: _newGroups);
      notifyListeners();
    }
  }

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
    _state = state.copyWith(restBetweenGroupsFixed: false);
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
      ..restBetweenGroupsFixed = state.restBetweenGroupsFixed
      ..restBetweenGroupsS =
          state.restBetweenGroupsFixed == true ? state.restBetweenGroupsS : null
      ..groups.replace(state.groups)
      ..name = state.name
      ..weightSystem = state.weightSystem);

    switch (_workoutType) {
      case WorkoutActions.newWorkout:
        _workoutsState.addWorkout(_newWorkout);
        break;
      case WorkoutActions.editWorkout:
        _workoutsState.editWorkout(_newWorkout);
        break;
      case WorkoutActions.viewWorkout:
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
