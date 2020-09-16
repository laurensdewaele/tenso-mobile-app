import 'package:flutter/cupertino.dart';
import 'package:tenso_app/modules/calendar/calendar.screen.dart';
import 'package:tenso_app/modules/completed_workout/completed_workout.screen.dart';
import 'package:tenso_app/modules/completed_workout/edit_completed_workout.screen.dart';
import 'package:tenso_app/modules/custom_board/custom_board.screen.dart';
import 'package:tenso_app/modules/custom_board/save_custom_board.screen.dart';
import 'package:tenso_app/modules/execution/execution.screen.dart';
import 'package:tenso_app/modules/feedback/feedback.screen.dart';
import 'package:tenso_app/modules/group/group.screen.dart';
import 'package:tenso_app/modules/info/info.screen.dart';
import 'package:tenso_app/modules/rate_workout/rate_workout.screen.dart';
import 'package:tenso_app/modules/settings/board_settings.screen.dart';
import 'package:tenso_app/modules/settings/settings.screen.dart';
import 'package:tenso_app/modules/stats/filter/filter.screen.dart';
import 'package:tenso_app/modules/stats/stats.screen.dart';
import 'package:tenso_app/modules/stats/total_hang_rest_time/total_hang_rest_time.screen.dart';
import 'package:tenso_app/modules/workout/workout.screen.dart';
import 'package:tenso_app/modules/workout_overview/workout_overview.screen.dart';
import 'package:tenso_app/screens/sound_settings.screen.dart';

abstract class Routes {
  static const String home = '/';
  static const String boardSettingsScreen = '/boardSettingsScreen';
  static const String calendarScreen = '/calendarScreen';
  static const String completedWorkoutScreen = '/completedWorkoutScreen';
  static const String customBoardScreen = '/customBoardScreen';
  static const String editCompletedWorkoutScreen =
      '/editCompletedWorkoutScreen';
  static const String executionScreen = '/executionScreen';
  static const String feedbackScreen = '/feedbackScreen';
  static const String filterScreen = '/filterScreen';
  static const String groupScreen = '/groupScreen';
  static const String infoScreen = '/infoScreen';
  static const String statsScreen = '/statsScreen';
  static const String saveCustomBoardScreen = '/saveCustomBoardScreen';
  static const String settingsScreen = '/settingsScreen';
  static const String soundSettingsScreen = '/soundSettingsScreen';
  static const String totalHangRestTimeScreen = '/totalHangRestTimeScreen';
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
    Routes.editCompletedWorkoutScreen: (context) =>
        EditCompletedWorkoutScreen(),
    Routes.executionScreen: (context) => ExecutionScreen(),
    Routes.feedbackScreen: (context) => FeedbackScreen(),
    Routes.filterScreen: (context) => FilterScreen(),
    Routes.groupScreen: (context) => GroupScreen(),
    Routes.home: (context) => WorkoutOverviewScreen(),
    Routes.infoScreen: (context) => InfoScreen(),
    Routes.statsScreen: (context) => StatsScreen(),
    Routes.rateWorkoutScreen: (context) => RateWorkoutScreen(),
    Routes.saveCustomBoardScreen: (context) => SaveCustomBoardScreen(),
    Routes.settingsScreen: (context) => SettingsScreen(),
    Routes.soundSettingsScreen: (context) => SoundSettingsScreen(),
    Routes.totalHangRestTimeScreen: (context) => TotalHangRestTimeScreen(),
    Routes.workoutScreen: (context) => WorkoutScreen(),
    Routes.workoutOverviewScreen: (context) => WorkoutOverviewScreen(),
  };
}
