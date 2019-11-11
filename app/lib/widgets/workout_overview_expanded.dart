import 'package:app/widgets/difficulty.dart';
import 'package:flutter/cupertino.dart';

import 'package:app/data/interfaces.dart';
import 'package:app/widgets/card.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/divider.dart';

class WorkoutOverviewExpanded extends StatelessWidget {
  const WorkoutOverviewExpanded(
      {@required this.workout, @required this.handleCollapse});

  final Workout workout;
  final VoidCallback handleCollapse;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: handleCollapse,
        child: Card(
            padding: EdgeInsets.all(styles.Spacings.m),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(workout.name, style: styles.Typography.title),
                  ],
                ),
                SectionDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    WorkoutInfo(
                      title: 'difficulty',
                      value: workout.difficulty.toString(),
                      difficultyColor: workout.difficultyColor,
                    ),
                    WorkoutInfo(
                      title: 'repetitions',
                      value: workout.holds[0].repetitions.toString(),
                    )
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    WorkoutInfo(
                      title: 'duration',
                      value: workout.duration.toString(),
                    ),
                    WorkoutInfo(
                      title: 'sets',
                      value: workout.sets.toString(),
                    )
                  ],
                ),
              ],
            )));
  }
}

class WorkoutInfo extends StatelessWidget {
  const WorkoutInfo(
      {@required this.title, @required this.value, this.difficultyColor});

  final String title;
  final String value;
  final Color difficultyColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(children: <Widget>[
      Container(
          child: Text(
        title,
        style: styles.Typography.subtitle,
      )),
      Container(
          margin: EdgeInsets.only(top: styles.Spacings.xs),
          child: difficultyColor != null
              ? Difficulty(
                  difficulty: value,
                  difficultyColor: difficultyColor,
                  width: styles.Spacings.xl,
                  height: styles.Spacings.xl)
              : Container(
                  height: styles.Spacings.xl,
                  width: styles.Spacings.xl,
                  child: Center(
                      child: Text(
                    value,
                    style: styles.Typography.indicatorBlack,
                  ))))
    ]));
  }
}
