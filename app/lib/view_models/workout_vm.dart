import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'package:uuid/uuid.dart';

import 'package:app/models/workout.dart';
import 'package:app/models/workouts.dart';
import 'package:app/state/app_state.dart';
import 'package:app/styles/styles.dart' as styles;

enum WorkoutTypes { newWorkout, editWorkout, viewWorkout }

class WorkoutViewModel extends ChangeNotifier {
  WorkoutViewModel();

  Uuid _uuid = Uuid();
  AppState _appState;
  List<Workout> get _workoutList => _appState?.workouts?.workouts?.toList();

  WorkoutTypes _workoutType;

  String _extraTabButtonText;
  String get extraTabButtonText => _extraTabButtonText;
  bool _inputsEnabled;
  bool get inputsEnabled => _inputsEnabled;
  Color _primaryColor;
  Color get primaryColor => _primaryColor;
  TextStyle _textPrimaryColor;
  TextStyle get textPrimaryColor => _textPrimaryColor;
  String _title;
  String get title => _title;

  void update(AppState appState) {
    _appState = appState;
  }

  void setWorkoutType(WorkoutTypes workoutType) {
    _workoutType = workoutType;

    switch (workoutType) {
      case WorkoutTypes.editWorkout:
        _extraTabButtonText = 'done';
        _inputsEnabled = true;
        _primaryColor = styles.Colors.blue;
        _textPrimaryColor = styles.Lato.xsBlue;
        _title = 'Edit workout';
        break;
      case WorkoutTypes.newWorkout:
        _extraTabButtonText = 'add';
        _inputsEnabled = true;
        _primaryColor = styles.Colors.primary;
        _textPrimaryColor = styles.Lato.xsPrimary;
        _title = 'New workout';
        break;
      case WorkoutTypes.viewWorkout:
        _extraTabButtonText = 'back';
        _inputsEnabled = false;
        _primaryColor = styles.Colors.gray;
        _textPrimaryColor = styles.Lato.xsGray;
        _title = 'View workout';
        break;
    }
    notifyListeners();
  }

  void setAndSaveWorkout(Workout workout) {
    _appState?.setWorkout(workout);

    if (_workoutType == WorkoutTypes.editWorkout) {
      _saveEditWorkout(workout);
    }

    if (_workoutType == WorkoutTypes.newWorkout) {
      _appState.saveNewWorkout(workout);
    }
  }

  void _saveEditWorkout(Workout editWorkout) {
    final Workout _originalWorkout =
        _workoutList.firstWhere((w) => w.id == _appState.workout.id);

    if (_originalWorkout != editWorkout) {
      final Workout _editedWorkout =
          editWorkout.rebuild((b) => b..editedId = _uuid.v4());
      final int index =
          _workoutList.indexWhere((w) => w.id == _editedWorkout.id);
      _workoutList[index] = _editedWorkout;
      _setAndSaveWorkouts(_appState?.workouts
          ?.rebuild((b) => b..workouts.replace(_workoutList)));
    }
  }

  void deleteWorkout(Workout workout) {
    _workoutList.removeWhere((w) => w.id == workout.id);
    _setAndSaveWorkouts(
        _appState?.workouts?.rebuild((b) => b..workouts.replace(_workoutList)));
  }

  void setActiveWorkout(Workout workout, WorkoutTypes workoutType) {
    setWorkoutType(workoutType);
    setAndSaveWorkout(workout);
  }

  void addNewWorkout(Workout workout) {
    if (_workoutType == WorkoutTypes.newWorkout) {
      setAndSaveWorkout(workout);
      _setAndSaveWorkouts(
          _appState?.workouts?.rebuild((b) => b..workouts.add(workout)));
    }
  }

  void _setAndSaveWorkouts(Workouts workouts) {
    _appState.setWorkouts(workouts);
    _appState.saveWorkouts(workouts);
  }
}
