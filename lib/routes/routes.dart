import 'package:flutter/cupertino.dart';
import 'package:tenso_app/screens/board_settings.screen.dart';
import 'package:tenso_app/screens/calendar.screen.dart';
import 'package:tenso_app/screens/completed_workout.screen.dart';
import 'package:tenso_app/screens/custom_board.screen.dart';
import 'package:tenso_app/screens/execution.screen.dart';
import 'package:tenso_app/screens/feedback.screen.dart';
import 'package:tenso_app/screens/group.screen.dart';
import 'package:tenso_app/screens/info.screen.dart';
import 'package:tenso_app/screens/progress.screen.dart';
import 'package:tenso_app/screens/rate_workout.screen.dart';
import 'package:tenso_app/screens/save_custom_board.screen.dart';
import 'package:tenso_app/screens/settings.screen.dart';
import 'package:tenso_app/screens/sound_settings.screen.dart';
import 'package:tenso_app/screens/workout.screen.dart';
import 'package:tenso_app/screens/workout_overview.screen.dart';

abstract class Routes {
  static const String home = '/';
  static const String boardSettingsScreen = '/boardSettingsScreen';
  static const String calendarScreen = '/calendarScreen';
  static const String completedWorkoutScreen = '/completedWorkoutScreen';
  static const String customBoardScreen = '/customBoardScreen';
  static const String executionScreen = '/executionScreen';
  static const String feedbackScreen = '/feedbackScreen';
  static const String groupScreen = '/groupScreen';
  static const String infoScreen = '/infoScreen';
  static const String progressScreen = '/progressScreen';
  static const String saveCustomBoardScreen = '/saveCustomBoardScreen';
  static const String settingsScreen = '/settingsScreen';
  static const String soundSettingsScreen = '/soundSettingsScreen';
  static const String rateWorkoutScreen = '/rateWorkoutScreen';
  static const String workoutScreen = '/workoutScreen';
  static const String workoutOverviewScreen = '/workoutOverviewScreen';
}

Map<String, WidgetBuilder> getRoutes(BuildContext context) {
  return {
    Routes.boardSettingsScreen: (context) => BoardSettingsScreen(),
    Routes.calendarScreen: (context) => CalendarScreen(),
    Routes.customBoardScreen: (context) => CustomBoardScreen(),
    Routes.completedWorkoutScreen: (context) => CompletedWorkoutScreen(),
    Routes.executionScreen: (context) => ExecutionScreen(),
    Routes.feedbackScreen: (context) => FeedbackScreen(),
    Routes.groupScreen: (context) => GroupScreen(),
    Routes.home: (context) => WorkoutOverviewScreen(),
    Routes.infoScreen: (context) => InfoScreen(),
    Routes.progressScreen: (context) => ProgressScreen(),
    Routes.rateWorkoutScreen: (context) => RateWorkoutScreen(),
    Routes.saveCustomBoardScreen: (context) => SaveCustomBoardScreen(),
    Routes.settingsScreen: (context) => SettingsScreen(),
    Routes.soundSettingsScreen: (context) => SoundSettingsScreen(),
    Routes.workoutScreen: (context) => WorkoutScreen(),
    Routes.workoutOverviewScreen: (context) => WorkoutOverviewScreen(),
  };
}
