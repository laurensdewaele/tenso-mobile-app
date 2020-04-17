import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:app/models/models.dart';
import 'package:app/state/app_state.dart';
import 'package:app/state/workouts_state.dart';

class WorkoutOverviewViewModel extends ChangeNotifier {
  List<Workout> _workoutList;
  List<Workout> get workoutList => _workoutList;
  bool startOpen;
  WorkoutsState _workoutsState;
  StreamSubscription _sub;

  AppState _appState;

  void update(AppState appState) {
    _appState = appState;
    startOpen = _appState?.deviceInfo?.firstLaunch ?? false;
    notifyListeners();
  }

  WorkoutOverviewViewModel({WorkoutsState workoutsState}) {
    _workoutsState = workoutsState;
    _workoutList = _workoutsState.workoutList;
    _sub = _workoutsState.workoutList$.listen((List<Workout> workoutList) {
      _workoutList = workoutList;
      notifyListeners();
    });
  }

  void deleteWorkout(Workout workout) {
    _workoutsState.deleteWorkout(workout);
  }

  void copyWorkout(Workout workout) {
    _workoutsState.copyWorkout(workout);
  }

  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
