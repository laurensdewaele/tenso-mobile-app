import 'dart:ui';

import 'package:app/models/workout.dart';
import 'package:app/state/app_state.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewOrEditWorkoutViewModel extends ChangeNotifier {
  NewOrEditWorkoutViewModel() {
    _title = 'New workout';
    _primaryColor = styles.Colors.primary;
    _textPrimaryColor = styles.Typography.textRed;
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
      _textPrimaryColor = styles.Typography.textRed;
      _title = 'New workout';
    } else {
      _isNewWorkout = false;
      _isEditWorkout = true;
      _primaryColor = styles.Colors.blue;
      _textPrimaryColor = styles.Typography.textBlue;
      _title = 'Edit workout';
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
}
