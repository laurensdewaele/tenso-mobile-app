import 'package:app/widgets/difficulty.dart';
import 'package:flutter/cupertino.dart';

import 'package:app/data/interfaces.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/card.dart';

class WorkoutOverviewCardCollapsed extends StatelessWidget {
  const WorkoutOverviewCardCollapsed(
      {@required this.workout, @required this.handleExpand});

  final Workout workout;
  final VoidCallback handleExpand;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleExpand,
      child: Card(
          padding: EdgeInsets.all(styles.Measurements.s),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(workout.name, style: styles.Typography.title),
                Difficulty(
                  difficulty: workout.difficulty.toString(),
                  difficultyColor: workout.difficultyColor,
                  width: styles.Measurements.xxl,
                  height: styles.Measurements.xxl,
                )
              ])),
    );
  }
}
