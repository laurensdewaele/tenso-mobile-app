import 'package:app/data/basic_workout.dart';
import 'package:app/models/completed_workout.dart';
import 'package:app/models/completed_workouts.dart';
import 'package:app/models/temp_unit.dart';

final CompletedWorkout completedWorkout = CompletedWorkout((b) => b
  ..id = '123'
  ..workout = basicWorkout.toBuilder()
  ..perceivedExertion = 3
  ..tempUnit = TempUnit.celsius
  ..completedDate = DateTime.utc(2020, 1, 1, 20, 17));

final CompletedWorkout completedWorkout2 = completedWorkout.rebuild((b) => b
  ..id = '1234'
  ..tempUnit = TempUnit.celsius
  ..completedDate = DateTime.utc(2020, 1, 4, 8, 45)
  ..perceivedExertion = 4);

final CompletedWorkout completedWorkout3 = completedWorkout.rebuild((b) => b
  ..id = '12345'
  ..tempUnit = TempUnit.celsius
  ..completedDate = DateTime.utc(2020, 1, 6, 7, 56)
  ..perceivedExertion = 7);

final CompletedWorkout completedWorkout4 = completedWorkout.rebuild((b) => b
  ..id = '123456'
  ..tempUnit = TempUnit.celsius
  ..completedDate = DateTime.utc(2020, 2, 8, 21, 32)
  ..perceivedExertion = 10);

final CompletedWorkout sameDayCompletedWorkout =
    completedWorkout.rebuild((b) => b
      ..id = '1234567'
      ..completedDate = DateTime.utc(2020, 2, 6, 15, 43)
      ..perceivedExertion = 1
      ..workout = basicWorkout.rebuild((b) => b..difficulty = 4).toBuilder());

final CompletedWorkout sameDayCompletedWorkout2 =
    completedWorkout.rebuild((b) => b
      ..id = '1234568'
      ..completedDate = DateTime.utc(2020, 2, 6, 13, 21)
      ..perceivedExertion = 1
      ..workout = basicWorkout.rebuild((b) => b..difficulty = 7).toBuilder());
final CompletedWorkout sameDayCompletedWorkout3 =
    completedWorkout.rebuild((b) => b
      ..id = '1234568'
      ..completedDate = DateTime.utc(2020, 2, 6, 11, 21)
      ..perceivedExertion = 1
      ..workout = basicWorkout.rebuild((b) => b..difficulty = 1).toBuilder());

final CompletedWorkouts completedWorkouts = CompletedWorkouts((b) => b
  ..completedWorkouts.addAll([
    completedWorkout,
    completedWorkout2,
    completedWorkout3,
    completedWorkout4,
    sameDayCompletedWorkout,
    sameDayCompletedWorkout2,
    sameDayCompletedWorkout3
  ]));
