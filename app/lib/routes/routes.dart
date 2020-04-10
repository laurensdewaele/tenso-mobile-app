import 'package:flutter/cupertino.dart';

import 'package:app/screens/calendar.dart';
import 'package:app/screens/congratulations.dart';
import 'package:app/screens/countdown.dart';
import 'package:app/screens/rate_workout.dart';
import 'package:app/screens/settings.dart';
import 'package:app/screens/sound_settings.dart';
import 'package:app/screens/workout.dart';
import 'package:app/screens/workout_overview.dart';

abstract class Routes {
  static const String home = '/';
  static const String workoutScreen = '/workoutScreen';
  static const String workoutOverviewScreen = '/workoutOverviewScreen';
  static const String settingsScreen = '/settingsScreen';
  static const String progressScreen = '/progressScreen';
  static const String soundSettingsScreen = '/soundSettingsScreen';
  static const String countdownScreen = '/countdownScreen';
  static const String calendarScreen = '/calendarScreen';
  static const String feedbackScreen = '/feedbackScreen';
  static const String congratulationsScreen = '/congratulationsScreen';
  static const String rateWorkoutScreen = '/rateWorkoutScreen';
}

Map<String, WidgetBuilder> getRoutes(BuildContext context) {
  return {
    Routes.home: (context) => WorkoutOverviewScreen(),
    Routes.workoutScreen: (context) => WorkoutScreen(),
    Routes.workoutScreen: (context) => WorkoutScreen(),
    Routes.workoutOverviewScreen: (context) => WorkoutOverviewScreen(),
    Routes.settingsScreen: (context) => SettingsScreen(),
    Routes.soundSettingsScreen: (context) => SoundSettingsScreen(),
    Routes.countdownScreen: (context) => CountdownScreen(),
    Routes.calendarScreen: (context) => CalendarScreen(),
    Routes.congratulationsScreen: (context) => CongratulationsScreen(),
    Routes.rateWorkoutScreen: (context) => RateWorkoutScreen(),
  };
}
