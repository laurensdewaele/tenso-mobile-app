import 'interfaces.dart';

final List<Workout> mockWorkouts = [
  Workout(
      name: 'Beginner routine',
      difficulty: 0,
      holds: [Hold(repetitions: 5)],
      duration: 25,
      sets: 5),
  Workout(
      name: 'Beginner routine',
      difficulty: 15,
      holds: [Hold(repetitions: 5), Hold(repetitions: 7)],
      duration: 25,
      sets: 5),
  Workout(
      name: 'Medium stuff',
      difficulty: 20,
      holds: [Hold(repetitions: 5)],
      duration: 30,
      sets: 3),
  Workout(
      name: 'Medium stuff',
      difficulty: 32,
      holds: [Hold(repetitions: 5)],
      duration: 30,
      sets: 3),
  Workout(
      name: 'Intermediate',
      difficulty: 40,
      holds: [Hold(repetitions: 5)],
      duration: 25,
      sets: 4),
  Workout(
      name: 'Tendon snapper',
      difficulty: 58,
      holds: [Hold(repetitions: 5)],
      duration: 25,
      sets: 4),
  Workout(
      name: 'Tendon snapper',
      difficulty: 60,
      holds: [Hold(repetitions: 5)],
      duration: 25,
      sets: 4),
  Workout(
      name: 'Tendon snapper',
      difficulty: 61,
      holds: [Hold(repetitions: 5)],
      duration: 25,
      sets: 4),
  Workout(
      name: 'Tendon snapper',
      difficulty: 80,
      holds: [Hold(repetitions: 5)],
      duration: 25,
      sets: 4),
  Workout(
      name: 'Tendon snapper',
      difficulty: 88,
      holds: [Hold(repetitions: 5)],
      duration: 25,
      sets: 4),
  Workout(
      name: 'Tendon snapper',
      difficulty: 100,
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
