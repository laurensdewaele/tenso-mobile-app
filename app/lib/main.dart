import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/data/basic_settings.dart';
import 'package:app/data/basic_workout.dart';
import 'package:app/routes/routes.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/view_models/settings.dart';
import 'package:app/view_models/workout.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsViewModel>(
          create: (context) => defaultSettingsViewModel,
        ),
        ChangeNotifierProvider<WorkoutViewModel>(
            create: (context) => basicWorkoutViewModel)
      ],
      child: CupertinoApp(
          routes: getRoutes(context), color: styles.Colors.primary),
    );
  }
}
