import 'package:flutter/cupertino.dart';

import 'package:app/data/mock_data.dart';
import 'package:app/models/workout_ui_configuration.dart';
import 'package:app/screens/new_workout.dart';
import 'package:app/screens/workout_overview.dart';

class Routes {
  Routes._();

  static const String home = '/';
  static const String newWorkoutScreen = '/newWorkoutScreen';
  static const String workoutOverviewScreen = '/workoutOverviewScreen';
  static const String settingsScreen = '/settingsScreen';
  static const String progressScreen = '/progressScreen';
}

final List<WorkoutSection> testSections = [
  WorkoutSection(title: 'Basics', workoutElements: [
    WorkoutElement(
        generalWorkoutConfigurationProperty:
            GeneralWorkoutConfigurationProperties.holdAmount,
        workoutInputType: WorkoutInputTypes.counter,
        description: 'different holds',
        initialIntValue: 5),
    WorkoutElement(
        generalWorkoutConfigurationProperty:
            GeneralWorkoutConfigurationProperties.repetitions,
        workoutInputType: WorkoutInputTypes.counter,
        description: 'repetitions per hold',
        initialIntValue: 5),
    WorkoutElement(
        generalWorkoutConfigurationProperty:
            GeneralWorkoutConfigurationProperties.sets,
        workoutInputType: WorkoutInputTypes.counter,
        description: 'sets',
        initialIntValue: 3),
  ]),
  WorkoutSection(title: 'Timers', workoutElements: [
    WorkoutElement(
        generalWorkoutConfigurationProperty:
            GeneralWorkoutConfigurationProperties.restBetweenRepetitions,
        workoutInputType: WorkoutInputTypes.slider,
        description: 'rest seconds between repetitions',
        initialIntValue: 30,
        minIntValue: 1,
        maxIntValue: 300),
    WorkoutElement(
        generalWorkoutConfigurationProperty:
            GeneralWorkoutConfigurationProperties.restBetweenSets,
        workoutInputType: WorkoutInputTypes.slider,
        description: 'rest seconds between sets',
        initialIntValue: 120,
        minIntValue: 1,
        maxIntValue: 600),
    WorkoutElement(
        generalWorkoutConfigurationProperty:
            GeneralWorkoutConfigurationProperties.hangTime,
        workoutInputType: WorkoutInputTypes.slider,
        description: 'hang time seconds',
        initialIntValue: 7,
        minIntValue: 1,
        maxIntValue: 180),
  ])
];

Map<String, WidgetBuilder> getRoutes(BuildContext context) {
  return {
    Routes.home: (context) => NewWorkoutScreen(workoutSections: testSections),
    // Replaced due to work on NewWorkoutScreen
//    Routes.home: (context) => WorkoutOverviewScreen(workouts: mockWorkouts),
//    Routes.newWorkoutScreen: (context) =>
//        NewWorkoutScreen(workoutSections: testSections),
    Routes.workoutOverviewScreen: (context) =>
        WorkoutOverviewScreen(workouts: mockWorkouts),
  };
}
