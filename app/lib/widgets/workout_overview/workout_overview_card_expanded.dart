import 'package:flutter/cupertino.dart' hide Icon;
import 'package:flutter/material.dart' hide Card, Divider, Icon;

import 'package:app/models/completed_workout.dart';
import 'package:app/models/workout.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/button.dart';
import 'package:app/widgets/difficulty.dart';
import 'package:app/widgets/icon.dart';
import 'package:app/widgets/divider.dart';

class WorkoutOverviewCardExpanded extends StatelessWidget {
  WorkoutOverviewCardExpanded({
    Key key,
    this.workout,
    this.completedWorkout,
    @required this.handleStart,
  }) : super(key: key);

  final Workout workout;
  final CompletedWorkout completedWorkout;
  final VoidCallback handleStart;

  @override
  Widget build(BuildContext context) {
    final Workout _workout = workout ?? completedWorkout.workout;
    final int _minutes = _workout.duration ~/ 60;
    final int _seconds = _workout.duration % 60;

    return Column(
      children: <Widget>[
        Divider(height: styles.Measurements.l),
        WorkoutRowOne(
          difficulty: _workout.difficulty.toString(),
          difficultyColor: _workout.difficultyColor,
          holdCount: _workout.holdCount.toString(),
        ),
        Divider(height: styles.Measurements.m),
        WorkoutRowTwo(
          sets: _workout.sets,
          durationMinutes: _minutes,
          durationSeconds: _seconds,
        ),
        Divider(height: styles.Measurements.m),
        Container(
            width: 175.0,
            child: Button(
                text: 'start', handleTap: handleStart, displayNextIcon: true)),
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
        style: styles.Staatliches.xsGray,
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
                    style: styles.Staatliches.lBlack,
                  ))))
    ]));
  }
}

class _WorkoutDuration extends StatelessWidget {
  _WorkoutDuration({Key key, this.seconds, this.minutes}) : super(key: key);

  final int minutes;
  final int seconds;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: styles.Measurements.xl,
        child: Center(
            child: RichText(
          text: TextSpan(
              text: minutes.toString(),
              style: styles.Staatliches.lBlack,
              children: [
                if (minutes != 0)
                  TextSpan(text: ' ', style: styles.Staatliches.textDivider),
                if (minutes != 0)
                  TextSpan(text: 'm', style: styles.Staatliches.xsBlack),
                if (seconds != 0)
                  TextSpan(text: '  ', style: styles.Staatliches.xsBlack),
                if (seconds != 0)
                  TextSpan(
                      text: seconds.toString(),
                      style: styles.Staatliches.lBlack),
                if (seconds != 0)
                  TextSpan(text: ' ', style: styles.Staatliches.textDivider),
                if (seconds != 0)
                  TextSpan(text: 's', style: styles.Staatliches.xsBlack)
              ]),
        )));
  }
}

class WorkoutRowOne extends StatelessWidget {
  WorkoutRowOne(
      {Key key,
      @required this.difficulty,
      @required this.difficultyColor,
      @required this.holdCount})
      : super(key: key);

  final Color difficultyColor;
  final String difficulty;
  final String holdCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _WorkoutInfo(
          title: 'difficulty',
          value: difficulty,
          difficultyColor: difficultyColor,
        ),
        _WorkoutInfo(
          title: 'holds',
          value: holdCount,
        ),
      ],
    );
  }
}

class WorkoutRowTwo extends StatelessWidget {
  WorkoutRowTwo(
      {Key key,
      @required this.sets,
      @required this.durationMinutes,
      @required this.durationSeconds})
      : super(key: key);

  final int sets;
  final int durationMinutes;
  final int durationSeconds;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _WorkoutInfo(
          title: 'sets',
          value: sets.toString(),
        ),
        Expanded(
            child: Column(children: <Widget>[
          Text(
            'duration',
            style: styles.Staatliches.xsGray,
          ),
          _WorkoutDuration(
            minutes: durationMinutes,
            seconds: durationSeconds,
          )
        ])),
      ],
    );
  }
}

class CompletedWorkoutRowOne extends StatelessWidget {
  CompletedWorkoutRowOne(
      {Key key,
      @required this.difficulty,
      @required this.difficultyColor,
      @required this.holdCount,
      @required this.feltDifficulty,
      @required this.feltDifficultyColor})
      : super(key: key);

  final Color difficultyColor;
  final String difficulty;
  final String holdCount;
  final String feltDifficulty;
  final Color feltDifficultyColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _WorkoutInfo(
          title: 'difficulty',
          value: difficulty,
          difficultyColor: difficultyColor,
        ),
        _WorkoutInfo(
          title: 'felt difficulty',
          value: holdCount,
          difficultyColor: feltDifficultyColor,
        ),
      ],
    );
  }
}
