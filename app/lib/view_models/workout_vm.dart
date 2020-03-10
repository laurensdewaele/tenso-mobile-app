import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'package:app/models/workout.dart';
import 'package:app/state/app_state.dart';
import 'package:app/styles/styles.dart' as styles;

enum WorkoutTypes { newWorkout, editWorkout, viewWorkout }

class WorkoutViewModel extends ChangeNotifier {
  WorkoutViewModel() {
    _title = 'New workout';
    _extraTabButtonText = 'save';
    _primaryColor = styles.Colors.primary;
    _textPrimaryColor = styles.Lato.xsPrimary;
  }
  AppState _appState;

  WorkoutTypes _workoutType;
  WorkoutTypes get workoutType => _workoutType;

  String _title;
  String get title => _title;
  String _extraTabButtonText;
  String get extraTabButtonText => _extraTabButtonText;
  Color _primaryColor;
  Color get primaryColor => _primaryColor;
  TextStyle _textPrimaryColor;
  TextStyle get textPrimaryColor => _textPrimaryColor;

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

  void update(AppState appState) {
    _appState = appState;
  }

  void setWorkoutType(WorkoutTypes workoutType) {
    _workoutType = workoutType;

    switch (workoutType) {
      case WorkoutTypes.editWorkout:
        _primaryColor = styles.Colors.blue;
        _textPrimaryColor = styles.Lato.xsBlue;
        _title = 'Edit workout';
        _extraTabButtonText = 'done';
        break;
      case WorkoutTypes.newWorkout:
        _primaryColor = styles.Colors.primary;
        _textPrimaryColor = styles.Lato.xsPrimary;
        _title = 'New workout';
        _extraTabButtonText = 'add';
        break;
      case WorkoutTypes.viewWorkout:
        _primaryColor = styles.Colors.gray;
        _textPrimaryColor = styles.Lato.xsGray;
        _title = 'View workout';
        _extraTabButtonText = 'done';
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
