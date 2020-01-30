import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/data/basic_settings.dart';
import 'package:app/data/basic_workout.dart';
import 'package:app/routes/routes.dart';
import 'package:app/services/persistence.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/active_workout.dart';
import 'package:app/view_models/general_tab.dart';
import 'package:app/view_models/settings.dart';
import 'package:app/view_models/workout.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PersistenceService>(create: (context) => PersistenceService()),
        ChangeNotifierProxyProvider<PersistenceService, WorkoutState>(
            update: (context, persistenceService, workoutState) =>
                WorkoutState(persistenceService)),
        ProxyProvider<WorkoutState, GeneralTabViewModel>(
            update: (context, workoutState, generalTabViewModel) =>
                GeneralTabViewModel(workoutState)),
        ChangeNotifierProvider<SettingsViewModel>(
          create: (context) => defaultSettingsViewModel,
        ),
        ChangeNotifierProvider<WorkoutViewModel>(
          create: (context) => WorkoutViewModel.fromWorkoutModel(basicWorkout),
        ),
        ChangeNotifierProvider<WorkoutViewModel>(
            create: (context) =>
                WorkoutViewModel.fromWorkoutModel(basicWorkout))
      ],
      child: CupertinoApp(
          routes: getRoutes(context), color: styles.Colors.primary),
    );
  }
}
