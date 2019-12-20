import 'package:flutter/cupertino.dart';

import 'package:app/data/mock_data.dart';
import 'package:app/models/settings.dart';
import 'package:app/models/workout_config.dart';
import 'package:app/screens/new_workout.dart';
import 'package:app/screens/settings.dart';
import 'package:app/screens/workout_overview.dart';

class Routes {
  Routes._();

  static const String home = '/';
  static const String newWorkoutScreen = '/newWorkoutScreen';
  static const String workoutOverviewScreen = '/workoutOverviewScreen';
  static const String settingsScreen = '/settingsScreen';
  static const String progressScreen = '/progressScreen';
}

final config = WorkoutConfig.fromSettings(Settings.advanced());

Map<String, WidgetBuilder> getRoutes(BuildContext context) {
  return {
    Routes.home: (context) => WorkoutOverviewScreen(workouts: mockWorkouts),
    Routes.newWorkoutScreen: (context) => NewWorkoutScreen(config: config),
    Routes.workoutOverviewScreen: (context) =>
        WorkoutOverviewScreen(workouts: mockWorkouts),
    Routes.settingsScreen: (context) => SettingsScreen()
  };
}
