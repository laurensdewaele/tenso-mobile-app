import 'dart:ui';

import 'package:app/models/workout.dart';
import 'package:app/state/app_state.dart';
import 'package:app/styles/styles.dart' as styles;


class NewOrEditWorkoutViewModel {
  NewOrEditWorkoutViewModel(AppState appState) {
    _appState = appState;
    _title = 'New workout';
    _primaryColor = styles.Colors.primary;
  }

  AppState _appState;

  bool _isNewWorkout = true;
  bool _isEditWorkout = false;
  bool get isNewWorkout => _isNewWorkout;
  bool get isEditWorkout => _isEditWorkout;

  String _title;
  String get title => _title;
  Color _primaryColor;
  Color get primaryColor => _primaryColor;

  Workout get workout {
    if (_isNewWorkout) {
      return _appState.newWorkout;
    } else {
      return _appState.editWorkout;
    }
  }

  void setNewWorkout({bool isNewWorkout, bool isEditWorkout}) {
    if (isNewWorkout) {
      _isNewWorkout = true;
      _isEditWorkout = false;
      _primaryColor = styles.Colors.primary;
      _title = 'New workout';
    } else {
      _isNewWorkout = false;
      _isEditWorkout = true;
      _primaryColor = styles.Colors.difficultyBlue;
      _title = 'Edit workout';
    }
  }

  void saveWorkout(Workout workout) {
    if (_isNewWorkout) {
      _appState.saveNewWorkout(workout);
    } else {
      _appState.saveEditWorkout(workout);
    }
  }
}
