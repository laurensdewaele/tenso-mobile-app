import 'package:flutter/cupertino.dart' hide Icon;

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
    final bool _isCompletedWorkout = completedWorkout != null;
    final Workout _workout = workout ?? completedWorkout.workout;
    final int _minutes = _workout.duration ~/ 60;
    final int _seconds = _workout.duration % 60;

    return Column(
      children: <Widget>[
        Divider(height: styles.Measurements.l),
        if (_isCompletedWorkout == false)
          _WorkoutRowOne(
            difficulty: _workout.difficulty.toString(),
            difficultyColor: _workout.difficultyColor,
            holdCount: _workout.holdCount.toString(),
          ),
        if (_isCompletedWorkout == true)
          _CompletedWorkoutRowOne(
            difficulty: _workout.difficulty,
            difficultyColor: _workout.difficultyColor,
            feltDifficulty: completedWorkout.feltDifficulty,
            feltDifficultyColor: completedWorkout.feltDifficultyColor,
          ),
        Divider(height: styles.Measurements.m),
        if (_isCompletedWorkout == false)
          _WorkoutRowTwo(
            sets: _workout.sets,
            durationMinutes: _minutes,
            durationSeconds: _seconds,
          ),
        if (_isCompletedWorkout == true)
          _CompletedWorkoutRowTwo(
            completedLocalDate: completedWorkout.completedLocalDate,
            durationSeconds: _seconds,
            durationMinutes: _minutes,
          ),
        Divider(height: styles.Measurements.m),
        Container(
            width: 175.0,
            child: Button(
                text: 'start',
                handleTap: handleStart,
                leadingIcon: Icon(
                    iconData: IconData(0xf488,
                        fontFamily: 'CupertinoIcons',
                        fontPackage: 'cupertino_icons'),
                    size: styles.IconMeasurements.l,
                    color: styles.Colors.white))),
        Divider(height: styles.Measurements.m),
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

class _WorkoutRowOne extends StatelessWidget {
  _WorkoutRowOne(
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

class _WorkoutRowTwo extends StatelessWidget {
  _WorkoutRowTwo(
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

class _CompletedWorkoutRowOne extends StatelessWidget {
  _CompletedWorkoutRowOne(
      {Key key,
      @required this.difficulty,
      @required this.difficultyColor,
      @required this.feltDifficulty,
      @required this.feltDifficultyColor})
      : super(key: key);

  final Color difficultyColor;
  final int difficulty;
  final int feltDifficulty;
  final Color feltDifficultyColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _WorkoutInfo(
          title: 'difficulty',
          value: difficulty.toString(),
          difficultyColor: difficultyColor,
        ),
        _WorkoutInfo(
          title: 'felt difficulty',
          value: feltDifficulty.toString(),
          difficultyColor: feltDifficultyColor,
        ),
      ],
    );
  }
}

class _CompletedWorkoutRowTwo extends StatelessWidget {
  _CompletedWorkoutRowTwo(
      {Key key,
      @required this.completedLocalDate,
      @required this.durationMinutes,
      @required this.durationSeconds})
      : super(key: key);

  final DateTime completedLocalDate;
  final int durationMinutes;
  final int durationSeconds;

  @override
  Widget build(BuildContext context) {
    final int hour = completedLocalDate.hour;
    final int minutes = completedLocalDate.minute;
    final String timeStamp = '$hour:$minutes';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _WorkoutInfo(
          title: 'completed at',
          value: timeStamp,
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
