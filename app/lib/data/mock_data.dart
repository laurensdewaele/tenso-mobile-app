import 'package:app/models/hold.dart';
import 'package:app/models/workout.dart';

final List<Workout> mockWorkouts = [
  Workout(
      name: 'Beginner routine',
      difficulty: '4A',
      holds: [Hold(repetitions: 5)],
      duration: 25,
      sets: 5),
  Workout(
      name: 'Beginner routine',
      difficulty: '5A',
      holds: [Hold(repetitions: 5), Hold(repetitions: 7)],
      duration: 25,
      sets: 5),
  Workout(
      name: 'Medium stuff',
      difficulty: '5B',
      holds: [Hold(repetitions: 5)],
      duration: 30,
      sets: 3),
  Workout(
      name: 'Medium stuff',
      difficulty: '6A',
      holds: [Hold(repetitions: 5)],
      duration: 30,
      sets: 3),
  Workout(
      name: 'Intermediate',
      difficulty: '7A',
      holds: [Hold(repetitions: 5)],
      duration: 25,
      sets: 4),
  Workout(
      name: 'Tendon snapper',
      difficulty: '8A',
      holds: [Hold(repetitions: 5)],
      duration: 25,
      sets: 4),
  Workout(
      name: 'Tendon snapper',
      difficulty: '9A',
      holds: [Hold(repetitions: 5)],
      duration: 25,
      sets: 4),
  Workout(
      name: 'Tendon snapper',
      difficulty: '9A',
      holds: [Hold(repetitions: 5)],
      duration: 25,
      sets: 4),
  Workout(
      name: 'Tendon snapper',
      difficulty: '9A',
      holds: [Hold(repetitions: 5)],
      duration: 25,
      sets: 4),
  Workout(
      name: 'Tendon snapper',
      difficulty: '4A',
      holds: [Hold(repetitions: 5)],
      duration: 25,
      sets: 4),
  Workout(
      name: 'Tendon snapper',
      difficulty: '4A',
      holds: [Hold(repetitions: 5)],
      duration: 25,
      sets: 4),
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
