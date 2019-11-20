import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Card, Divider;

import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/buttons.dart';
import 'package:app/widgets/difficulty.dart';
import 'package:app/widgets/dividers.dart';

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
        SectionDivider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _WorkoutInfo(
              title: 'difficulty',
              value: workout.difficulty.toString(),
              difficultyColor: workout.difficultyColor,
            ),
            _WorkoutInfo(
              title: 'repetitions',
              value: workout.repetitions,
            ),
          ],
        ),
        Divider(),
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
        Divider(),
        Container(
            width: 175.0,
            child: Button(text: 'start', handleTap: handleStart)),
        Divider(),
        Icon(Icons.keyboard_arrow_up,
            size: styles.Measurements.l, color: styles.Colors.primary)
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
