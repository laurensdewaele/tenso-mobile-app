import 'package:flutter/cupertino.dart';

import 'package:app/helpers/unique_id.dart';
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
    _setAndSaveWorkouts(_appState?.workouts
        ?.rebuild((b) => b..workouts.replace(_newWorkoutList)));
  }

  void copyWorkout(Workout workout) {
    _setAndSaveWorkouts(_appState.workouts?.rebuild((b) => b
      ..workouts.add(workout.rebuild((b) => b
        ..id = generateUniqueId()
        ..name = '${workout.name} copy'))));
  }

  void _setAndSaveWorkouts(Workouts workouts) {
    _appState?.setWorkouts(workouts);
    _appState?.saveWorkouts(workouts);
  }
}
