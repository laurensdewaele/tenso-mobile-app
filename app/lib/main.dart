import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/data/basic_settings.dart';
import 'package:app/data/basic_workout.dart';
import 'package:app/routes/routes.dart';
import 'package:app/services/persistence.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/app_state.dart';
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
        ChangeNotifierProvider(
            create: (context) => AppState(
                Provider.of<PersistenceService>(context, listen: false))),
        Provider<GeneralTabViewModel>(
            create: (context) => GeneralTabViewModel(
                Provider.of<AppState>(context, listen: false))),
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
