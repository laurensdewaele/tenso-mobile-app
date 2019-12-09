import 'package:app/models/board.dart';
import 'package:app/models/hold.dart';
import 'package:app/models/workout.dart';

final Workout mockWorkout = Workout(
  difficulty: '7A',
  duration: 20 * 60,
  sets: 3,
  holdAmount: 3,
  restBetweenSets: 60 * 3,
  board: beastmaker1000,
  holds: [
    Hold(
        grip: '2 handed',
        handHold: HandHolds.twoHanded,
        boardHolds: beastmaker1000.holds,
        repetitions: 8,
        restBeforeNextHold: 60 * 2,
        restBetweenRepetitions: 60,
        hangTime: 7,
        addedWeight: 0)
  ],
  name: 'Latest workout',
);

final List<Workout> mockWorkouts = [
  mockWorkout,
  mockWorkout,
  mockWorkout,
  mockWorkout,
  mockWorkout,
  mockWorkout,
  mockWorkout,
];

final List<Workout> mockAlotOfWorkouts = [
  ...mockWorkouts,
  ...mockWorkouts,
  ...mockWorkouts,
  ...mockWorkouts,
  ...mockWorkouts,
  ...mockWorkouts,
  ...mockWorkouts,
  ...mockWorkouts,
  ...mockWorkouts,
  ...mockWorkouts,
  ...mockWorkouts,
  ...mockWorkouts,
  ...mockWorkouts,
  ...mockWorkouts
];
