import 'package:app/data/basic_workout.dart';
import 'package:app/models/workout.dart';
import 'package:flutter/cupertino.dart';

import 'package:app/view_models/app_state_vm.dart';

class ActiveWorkoutViewModel extends ChangeNotifier {
  ActiveWorkoutViewModel(BuildContext context) {
    _context = context;
  }

  BuildContext _context;
  AppState _appState;
  Workout get workout {
    if (_appState == null) {
      return basicWorkout;
    } else {
      return _appState.workout;
    }
  }

  int get holdCount => workout.holdCount;

  int _currentHold;
  int get currentHold => currentHold;

  void update(BuildContext context, AppState appState) {
    _appState = appState;
    _context = context;
  }
}
