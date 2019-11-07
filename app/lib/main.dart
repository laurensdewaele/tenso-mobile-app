import 'package:app/screens/overview.dart';
import 'package:app/screens/workout.dart';

import 'package:app/styles/styles.dart' as styles;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(App());

Map<String, WidgetBuilder> getRoutes(BuildContext context) {
  return {
    '/': (context) => OverviewScreen(),
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
