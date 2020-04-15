import 'package:flutter/cupertino.dart';

import 'package:app/models/models.dart';
import 'package:app/state/app_state.dart';

class WorkoutOverviewViewModel extends ChangeNotifier {
  WorkoutOverviewViewModel();
  AppState _appState;
  List<Workout> workoutList;
  bool startOpen;

  void update(AppState appState) {
    _appState = appState;
    workoutList = _appState?.workouts?.workouts?.toList();
    startOpen = _appState?.deviceInfo?.firstLaunch ?? false;
    notifyListeners();
  }

  void deleteWorkout(Workout workout) {
    final _newWorkoutList = []..addAll(workoutList);
    _newWorkoutList.removeWhere((w) => w.id == workout.id);
    _appState.setWorkouts(_appState?.workouts
        ?.rebuild((b) => b..workouts.replace(_newWorkoutList)));
  }
}
