import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'package:app/data/interfaces.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/button.dart';
import 'package:app/widgets/dividers.dart';
import 'package:app/widgets/screen.dart';
import 'package:app/widgets/workout_overview_card.dart';

class OverviewScreen extends StatelessWidget {
  OverviewScreen({@required this.workouts})
      : multipleWorkouts = [
          ...workouts,
          ...workouts,
          ...workouts,
          ...workouts,
          ...workouts,
          ...workouts,
          ...workouts,
        ];

  final List<Workout> workouts;
  final List<Workout> multipleWorkouts;

  void _handleAddWorkout() {
    print('Add workout!');
  }

  @override
  Widget build(BuildContext context) {
    final List<WorkoutOverviewCard> workoutWidgets = multipleWorkouts
        .map((workout) => WorkoutOverviewCard(workout: workout));
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final double viewHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    return Screen(
        gradientStartColor: styles.Colors.bgGrayStart,
        gradientStopColor: styles.Colors.bgGrayStop,
        child: ListView(children: <Widget>[...workoutWidgets]));
  }
}
