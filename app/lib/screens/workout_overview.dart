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
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final double viewHeight =
        MediaQuery.of(context).size.height - padding.top - padding.bottom;
    return Screen(
        gradientStartColor: styles.Colors.bgGrayStart,
        gradientStopColor: styles.Colors.bgGrayStop,
        child: ListView.separated(
          itemCount: multipleWorkouts.length + 2,
          itemBuilder: (BuildContext context, int index) {
            if (index < multipleWorkouts.length) {
              return WorkoutOverviewCard(workout: multipleWorkouts[index]);
            } else if (index == multipleWorkouts.length) {
              return Button(
                  text: 'Add workout', handleClick: _handleAddWorkout);
            } else {
              return SizedBox(height: viewHeight / 2 - styles.Measurements.m);
            }
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ));
  }
}
