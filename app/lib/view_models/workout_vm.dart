import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'package:app/models/workout.dart';
import 'package:app/state/app_state.dart';
import 'package:app/styles/styles.dart' as styles;

class WorkoutViewModel extends ChangeNotifier {
  WorkoutViewModel() {
    _title = 'New workout';
    _extraTabButtonText = 'save';
    _primaryColor = styles.Colors.primary;
    _textPrimaryColor = styles.Lato.xsPrimary;
  }
  AppState _appState;

  bool _isNewWorkout = true;
  bool _isEditWorkout = false;
  bool get isNewWorkout => _isNewWorkout;
  bool get isEditWorkout => _isEditWorkout;

  String _title;
  String get title => _title;
  String _extraTabButtonText;
  String get extraTabButtonText => _extraTabButtonText;
  Color _primaryColor;
  Color get primaryColor => _primaryColor;
  TextStyle _textPrimaryColor;
  TextStyle get textPrimaryColor => _textPrimaryColor;

  Workout get workout {
    if (_isNewWorkout) {
      return _appState?.newWorkout;
    } else {
      return _appState?.editWorkout;
    }
  }

  void update(AppState appState) {
    _appState = appState;
  }

  void setWorkoutType({bool isNewWorkout, bool isEditWorkout}) {
    if (isNewWorkout == true) {
      _isNewWorkout = true;
      _isEditWorkout = false;
      _primaryColor = styles.Colors.primary;
      _textPrimaryColor = styles.Lato.xsPrimary;
      _title = 'New workout';
      _extraTabButtonText = 'add';
    } else {
      _isNewWorkout = false;
      _isEditWorkout = true;
      _primaryColor = styles.Colors.blue;
      _textPrimaryColor = styles.Lato.xsBlue;
      _title = 'Edit workout';
      _extraTabButtonText = 'done';
    }
    notifyListeners();
  }

  void saveWorkout(Workout workout) {
    if (_isNewWorkout == true) {
      _appState?.saveNewWorkout(workout);
    } else {
      _appState?.saveEditWorkout(workout);
    }
  }

  void setActiveEditWorkout(Workout workout) {
    _appState?.saveEditWorkout(workout);
  }

  void addNewWorkoutToWorkouts() {
    if (_isNewWorkout) {
      _appState?.addNewWorkoutToWorkouts();
    }
  }
}
