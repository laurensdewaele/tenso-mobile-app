import 'package:flutter/cupertino.dart';

import 'package:app/data/mock_data.dart';
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

Map<String, WidgetBuilder> getRoutes(BuildContext context) {
  return {
    Routes.home: (context) => NewWorkoutScreen(),
    // Replaced due to work on NewWorkoutScreen
    // Routes.home: (context) => WorkoutOverviewScreen(workouts: mockWorkouts),
    Routes.newWorkoutScreen: (context) => NewWorkoutScreen(),
    Routes.workoutOverviewScreen: (context) =>
        WorkoutOverviewScreen(workouts: mockWorkouts),
  };
}
