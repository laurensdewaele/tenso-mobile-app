import 'package:flutter/cupertino.dart';

import 'package:app/data/mock_data.dart';
import 'package:app/screens/new_or_edit_workout.dart';
import 'package:app/screens/settings.dart';
import 'package:app/screens/sound_settings.dart';
import 'package:app/screens/workout_overview.dart';

abstract class Routes {
  static const String home = '/';
  static const String newOrEditWorkoutScreen = '/newOrEditWorkoutScreen';
  static const String workoutOverviewScreen = '/workoutOverviewScreen';
  static const String settingsScreen = '/settingsScreen';
  static const String progressScreen = '/progressScreen';
  static const String soundSettingsScreen = '/soundSettingsScreen';
}

Map<String, WidgetBuilder> getRoutes(BuildContext context) {
  return {
    Routes.home: (context) => WorkoutOverviewScreen(workouts: mockWorkouts),
    Routes.newOrEditWorkoutScreen: (context) => NewOrEditWorkoutScreen(),
    Routes.workoutOverviewScreen: (context) =>
        WorkoutOverviewScreen(workouts: mockWorkouts),
    Routes.settingsScreen: (context) => SettingsScreen(),
    Routes.soundSettingsScreen: (context) => SoundSettingsScreen()
  };
}
