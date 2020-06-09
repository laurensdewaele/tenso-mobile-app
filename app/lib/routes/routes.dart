import 'package:app/screens/board_settings.screen.dart';
import 'package:app/screens/calendar.screen.dart';
import 'package:app/screens/congratulations.screen.dart';
import 'package:app/screens/custom_board.screen.dart';
import 'package:app/screens/execution.screen.dart';
import 'package:app/screens/group.screen.dart';
import 'package:app/screens/rate_workout.screen.dart';
import 'package:app/screens/save_custom_board.screen.dart';
import 'package:app/screens/settings.screen.dart';
import 'package:app/screens/sound_settings.screen.dart';
import 'package:app/screens/workout_2.screen.dart';
import 'package:app/screens/workout_overview.screen.dart';
import 'package:flutter/cupertino.dart';

abstract class Routes {
  static const String home = '/';
  static const String boardSettingsScreen = '/boardSettingsScreen';
  static const String workoutScreen = '/workoutScreen';
  static const String groupScreen = '/groupScreen';
  static const String workoutOverviewScreen = '/workoutOverviewScreen';
  static const String settingsScreen = '/settingsScreen';
  static const String progressScreen = '/progressScreen';
  static const String soundSettingsScreen = '/soundSettingsScreen';
  static const String executionScreen = '/executionScreen';
  static const String calendarScreen = '/calendarScreen';
  static const String feedbackScreen = '/feedbackScreen';
  static const String congratulationsScreen = '/congratulationsScreen';
  static const String rateWorkoutScreen = '/rateWorkoutScreen';
  static const String customBoardScreen = '/customBoardScreen';
  static const String saveCustomBoardScreen = '/saveCustomBoardScreen';
}

Map<String, WidgetBuilder> getRoutes(BuildContext context) {
  return {
    Routes.home: (context) => WorkoutOverviewScreen(),
    Routes.workoutScreen: (context) => WorkoutScreen2(),
    Routes.groupScreen: (context) => GroupScreen(),
    Routes.workoutOverviewScreen: (context) => WorkoutOverviewScreen(),
    Routes.settingsScreen: (context) => SettingsScreen(),
    Routes.soundSettingsScreen: (context) => SoundSettingsScreen(),
    Routes.executionScreen: (context) => ExecutionScreen(),
    Routes.calendarScreen: (context) => CalendarScreen(),
    Routes.congratulationsScreen: (context) => CongratulationsScreen(),
    Routes.rateWorkoutScreen: (context) => RateWorkoutScreen(),
    Routes.boardSettingsScreen: (context) => BoardSettingsScreen(),
    Routes.customBoardScreen: (context) => CustomBoardScreen(),
    Routes.saveCustomBoardScreen: (context) => SaveCustomBoardScreen()
  };
}
