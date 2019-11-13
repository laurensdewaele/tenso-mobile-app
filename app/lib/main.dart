import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:app/models/mock_data.dart';
import 'package:app/screens/new_workout.dart';
import 'package:app/screens/workout_overview.dart';
import 'package:app/styles/styles.dart' as styles;

void main() => runApp(App());

Map<String, WidgetBuilder> getRoutes(BuildContext context) {
  return {
    '/': (context) => WorkoutOverviewScreen(workouts: mockWorkouts),
    '/workout': (context) => WorkoutScreen()
  };
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        routes: getRoutes(context), color: styles.Colors.primary);
  }
}
