import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import 'package:app/data/basic_workout.dart';
import 'package:app/routes/routes.dart';
import 'package:app/state/settings.dart';
import 'package:app/state/workout.dart';
import 'package:app/styles/styles.dart' as styles;

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsState>(
          create: (context) => defaultSettings,
        ),
        ChangeNotifierProvider<WorkoutState>(
            create: (context) => basicWorkoutState)
      ],
      child: CupertinoApp(
          routes: getRoutes(context), color: styles.Colors.primary),
    );
  }
}
