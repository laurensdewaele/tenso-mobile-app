import 'package:flutter/cupertino.dart' hide Icon;
import 'package:flutter/material.dart' hide Card, Divider, Icon;

import 'package:app/models/workout.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/button.dart';
import 'package:app/widgets/difficulty.dart';
import 'package:app/widgets/icon.dart';
import 'package:app/widgets/divider.dart';

class WorkoutOverviewCardExpanded extends StatelessWidget {
  WorkoutOverviewCardExpanded({
    Key key,
    @required this.workout,
    @required this.handleStart,
  }) : super(key: key);

  final Workout workout;
  final VoidCallback handleStart;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(height: styles.Measurements.l),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _WorkoutInfo(
              title: 'difficulty',
              value: workout.difficulty.toString(),
              difficultyColor: workout.difficultyColor,
            ),
            _WorkoutInfo(
              title: 'holds',
              value: workout.holdCount.toString(),
            ),
          ],
        ),
        Divider(height: styles.Measurements.m),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _WorkoutInfo(
              title: 'sets',
              value: workout.sets.toString(),
            ),
            _WorkoutInfo(
              title: 'duration',
              value: workout.duration.toString(),
            ),
          ],
        ),
        Divider(height: styles.Measurements.m),
        Container(
            width: 175.0, child: Button(text: 'start', handleTap: handleStart, displayNextIcon: true)),
        Divider(height: styles.Measurements.m),
        Icon(
            iconData: IconData(0xf3d8,
                fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
            size: styles.Measurements.l,
            color: styles.Colors.primary)
      ],
    );
  }
}

class _WorkoutInfo extends StatelessWidget {
  const _WorkoutInfo(
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
