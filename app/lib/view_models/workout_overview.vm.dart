import 'dart:async';

import 'package:app/models/models.dart';
import 'package:app/state/user.state.dart';
import 'package:app/state/workouts.state.dart';
import 'package:flutter/cupertino.dart';

class WorkoutOverviewViewModel extends ChangeNotifier {
  List<Workout> _workoutList;
  List<Workout> get workoutList => _workoutList;
  bool startOpen;
  WorkoutsState _workoutsState;
  StreamSubscription _sub;

  WorkoutOverviewViewModel() {
    startOpen = UserState().deviceInfo.firstLaunch;
    _workoutsState = WorkoutsState();
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
