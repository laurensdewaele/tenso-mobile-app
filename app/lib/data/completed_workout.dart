import 'package:app/data/basic_workout.dart';
import 'package:app/models/completed_workout.dart';
import 'package:app/models/completed_workouts.dart';

final CompletedWorkout completedWorkout = CompletedWorkout((b) => b
  ..workout = basicWorkout.toBuilder()
  ..feltDifficulty = 3
  ..date = DateTime.utc(2020, 3, 1));

final CompletedWorkout completedWorkout2 = completedWorkout.rebuild((b) => b
  ..date = DateTime.utc(2020, 3, 4)
  ..feltDifficulty = 4);

final CompletedWorkout completedWorkout3 = completedWorkout.rebuild((b) => b
  ..date = DateTime.utc(2020, 3, 6)
  ..feltDifficulty = 7);

final CompletedWorkout completedWorkout4 = completedWorkout.rebuild((b) => b
  ..date = DateTime.utc(2020, 3, 8)
  ..feltDifficulty = 10);

final CompletedWorkout sameDayCompletedWorkout =
    completedWorkout.rebuild((b) => b
      ..date = DateTime.utc(2020, 3, 6)
      ..feltDifficulty = 1
      ..workout = basicWorkout.rebuild((b) => b..difficulty = 4).toBuilder());

final CompletedWorkout sameDayCompletedWorkout2 =
    completedWorkout.rebuild((b) => b
      ..date = DateTime.utc(2020, 3, 6)
      ..feltDifficulty = 1
      ..workout = basicWorkout.rebuild((b) => b..difficulty = 7).toBuilder());

final CompletedWorkouts completedWorkouts = CompletedWorkouts((b) => b
  ..completedWorkouts.addAll([
    completedWorkout,
    completedWorkout2,
    completedWorkout3,
    completedWorkout4,
    sameDayCompletedWorkout,
    sameDayCompletedWorkout2
  ]));
