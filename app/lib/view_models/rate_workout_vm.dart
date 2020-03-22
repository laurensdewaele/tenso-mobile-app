import 'package:app/models/completed_workouts.dart';
import 'package:uuid/uuid.dart';

import 'package:app/models/completed_workout.dart';
import 'package:app/models/workout.dart';
import 'package:app/state/app_state.dart';

class RateWorkoutViewModel {
  RateWorkoutViewModel({AppState appState}) {
    _appState = appState;
    _uuid = Uuid();
  }

  AppState _appState;
  Uuid _uuid;

  saveCompletedWorkout({Workout workout, int feltDifficulty}) {
    final CompletedWorkout completedWorkout = CompletedWorkout((b) => b
      ..workout = workout.toBuilder()
      ..feltDifficulty = feltDifficulty
      ..completedDate = DateTime.now().toUtc()
      ..id = _uuid.v4());

    final _completedWorkouts = _appState.completedWorkouts
        .rebuild((b) => b..completedWorkouts.add(completedWorkout));
    _setAndSaveCompletedWorkouts(_completedWorkouts);
  }

  _setAndSaveCompletedWorkouts(CompletedWorkouts completedWorkouts) {
    _appState.setCompletedWorkouts(completedWorkouts);
    _appState.saveCompletedWorkouts(completedWorkouts);
  }
}
