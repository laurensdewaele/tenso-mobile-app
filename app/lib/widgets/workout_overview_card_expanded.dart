import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Card, Divider;

import 'package:app/data/interfaces.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/button.dart';
import 'package:app/widgets/card.dart';
import 'package:app/widgets/difficulty.dart';
import 'package:app/widgets/dividers.dart';
import 'package:flutter/material.dart' as prefix0;

class WorkoutOverviewCardExpanded extends StatelessWidget {
  const WorkoutOverviewCardExpanded(
      {@required this.workout,
      @required this.handleCollapse,
      @required this.handleStart});

  final Workout workout;
  final VoidCallback handleCollapse;
  final VoidCallback handleStart;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: handleCollapse,
        child: Card(
            padding: EdgeInsets.all(styles.Measurements.m),
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
                      value: workout.repetitions,
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
                Divider(),
                GestureDetector(
                  onTap: handleStart,
                  child: Container(
                      width: 175.0,
                      child: Button(text: 'start', handleClick: handleStart)),
                ),
                Divider(),
                Icon(Icons.keyboard_arrow_up,
                    size: styles.Measurements.l, color: styles.Colors.primary)
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
      Text(
        title,
        style: styles.Typography.subtitle,
      ),
      Container(
          margin: EdgeInsets.only(top: styles.Measurements.xs),
          child: difficultyColor != null
              ? Difficulty(
                  difficulty: value,
                  difficultyColor: difficultyColor,
                  width: styles.Measurements.xl,
                  height: styles.Measurements.xl)
              : Container(
                  height: styles.Measurements.xl,
                  child: Center(
                      child: Text(
                    value,
                    textAlign: TextAlign.center,
                    style: styles.Typography.indicatorBlack,
                  ))))
    ]));
  }
}
