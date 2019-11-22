import 'package:flutter/cupertino.dart';

import 'package:app/data/mock_data.dart';
import 'package:app/screens/new_workout.dart';
import 'package:app/screens/workout_overview.dart';

enum Routes {
  home,
  workoutScreen,
  workoutOverviewScreen,
  settingsScreen,
  progressScreen
}

const Map<Routes, String> _routes = {
  Routes.home: '/',
  Routes.workoutScreen: '/workoutScreen',
  Routes.workoutOverviewScreen: '/workoutOverviewScreen',
  Routes.settingsScreen: '/settingsScreen',
  Routes.progressScreen: '/progressScreen'
};

Map<String, WidgetBuilder> getRoutes(BuildContext context) {
  return {
    _routes[Routes.home]: (context) =>
        WorkoutOverviewScreen(workouts: mockWorkouts),
    _routes[Routes.workoutScreen]: (context) => WorkoutScreen(),
    _routes[Routes.workoutOverviewScreen]: (context) =>
        WorkoutOverviewScreen(workouts: mockWorkouts),
  };
}
