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

  saveWorkout({Workout workout, int feltDifficulty}) {
    final DateTime now = DateTime.now().toUtc();
    final CompletedWorkout completedWorkout = CompletedWorkout((b) => b
      ..workout = workout.toBuilder()
      ..feltDifficulty = feltDifficulty
      ..completedDate = now
      ..id = _uuid.v4());

    _appState.saveCompletedWorkouts(_appState.completedWorkouts
        .rebuild((b) => b..completedWorkouts.add(completedWorkout)));
  }
}
