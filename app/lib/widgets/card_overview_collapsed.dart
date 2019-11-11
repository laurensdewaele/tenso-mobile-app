import 'package:app/widgets/difficulty.dart';
import 'package:flutter/cupertino.dart';

import 'package:app/data/interfaces.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/card.dart';

class CardOverviewCollapsed extends StatelessWidget {
  const CardOverviewCollapsed(
      {@required this.workout, @required this.handleExpand});

  final Workout workout;
  final VoidCallback handleExpand;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleExpand,
      child: Card(
          padding: EdgeInsets.all(styles.Spacings.s),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(workout.name, style: styles.Typography.title),
                Difficulty(
                  difficulty: workout.difficulty,
                  difficultyColor: workout.difficultyColor,
                )
              ])),
    );
  }
}
