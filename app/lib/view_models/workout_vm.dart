import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'package:app/models/workout.dart';
import 'package:app/state/app_state.dart';
import 'package:app/styles/styles.dart' as styles;

enum WorkoutTypes { newWorkout, editWorkout, viewWorkout }

class WorkoutViewModel extends ChangeNotifier {
  WorkoutViewModel();

  AppState _appState;
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
  Workout get workout {
    switch (workoutType) {
      case WorkoutTypes.editWorkout:
        return _appState?.editWorkout;
        break;
      case WorkoutTypes.newWorkout:
        return _appState?.newWorkout;
        break;
      case WorkoutTypes.viewWorkout:
        return _appState?.viewWorkout;
        break;
      default:
        return _appState?.newWorkout;
    }
  }

  WorkoutTypes _workoutType;
  WorkoutTypes get workoutType => _workoutType;

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

  void saveWorkout(Workout workout) {
    switch (workoutType) {
      case WorkoutTypes.editWorkout:
        _appState?.saveEditWorkout(workout);
        break;
      case WorkoutTypes.newWorkout:
        _appState?.saveNewWorkout(workout);
        break;
      case WorkoutTypes.viewWorkout:
        _appState?.setViewWorkout(workout);
        break;
    }
  }

  void setActiveWorkout(Workout workout, WorkoutTypes workoutType) {
    setWorkoutType(workoutType);
    saveWorkout(workout);
  }

  void addNewWorkoutToWorkouts() {
    if (workoutType == WorkoutTypes.newWorkout) {
      _appState?.addNewWorkoutToWorkouts();
    }
  }
}
