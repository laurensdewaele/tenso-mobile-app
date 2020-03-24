import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/models/completed_workout.dart';
import 'package:app/models/unit.dart';
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

    return Column(
      children: <Widget>[
        Divider(height: styles.Measurements.l),
        if (_isCompletedWorkout == false)
          _DifficultyAndDuration(
              difficulty: _workout.difficulty,
              difficultyColor: _workout.difficultyColor,
              duration: _workout.duration),
        if (_isCompletedWorkout == true)
          _DifficultyAndPerceivedExertion(
            difficulty: _workout.difficulty,
            difficultyColor: _workout.difficultyColor,
            perceivedExertion: completedWorkout.perceivedExertion,
            perceivedExertionColor: completedWorkout.perceivedExertionColor,
          ),
        Divider(height: styles.Measurements.m),
        _AvHangTimeAndAddedWeight(
            unit: _workout.unit,
            averageAddedWeight: _calculateAverageAddedWeight(_workout),
            averageHangTime: _calculateAverageHangTime(_workout)),
        Divider(height: styles.Measurements.m),
        if (_isCompletedWorkout == false)
          _HoldsAndSets(
            holdCount: _workout.holdCount,
            sets: _workout.sets,
          ),
        if (_isCompletedWorkout == true)
          _CompletedAtAndTotalDuration(
              completedLocalDate: completedWorkout.completedLocalDate,
              duration: _workout.duration),
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

class _WorkoutDuration extends StatelessWidget {
  _WorkoutDuration({Key key, @required this.seconds}) : super(key: key);

  final int seconds;

  @override
  Widget build(BuildContext context) {
    final int _minutes = seconds ~/ 60;
    final int _remainingSeconds = seconds % 60;

    return Container(
        child: Center(
            child: RichText(
      text: TextSpan(text: null, children: [
        if (_minutes != 0)
          TextSpan(text: _minutes.toString(), style: styles.Lato.xsGray),
        if (_minutes != 0)
          TextSpan(text: ' ', style: styles.Staatliches.textDivider),
        if (_minutes != 0) TextSpan(text: 'm', style: styles.Lato.xsGray),
        if (_remainingSeconds != 0)
          TextSpan(text: '  ', style: styles.Lato.xsGray),
        if (_remainingSeconds != 0)
          TextSpan(
              text: _remainingSeconds.toString(), style: styles.Lato.xsGray),
        if (_remainingSeconds != 0)
          TextSpan(text: ' ', style: styles.Staatliches.textDivider),
        if (_remainingSeconds != 0)
          TextSpan(text: 's', style: styles.Lato.xsGray)
      ]),
    )));
  }
}

class _DifficultyAndDuration extends StatelessWidget {
  _DifficultyAndDuration(
      {Key key,
      @required this.difficulty,
      @required this.difficultyColor,
      @required this.duration})
      : super(key: key);

  final Color difficultyColor;
  final int difficulty;
  final int duration;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
            child: Column(children: <Widget>[
          Text(
            'difficulty',
            style: styles.Staatliches.xsBlack,
          ),
          Divider(
            height: styles.Measurements.xs,
          ),
          Difficulty(
              difficulty: difficulty.toString(),
              difficultyColor: difficultyColor,
              width: styles.Measurements.xl,
              height: styles.Measurements.xl)
        ])),
        Expanded(
            child: Column(children: <Widget>[
          Text(
            'total duration',
            style: styles.Staatliches.xsBlack,
          ),
          Divider(
            height: styles.Measurements.xs,
          ),
          Container(
              height: styles.Measurements.xl,
              child: _WorkoutDuration(seconds: duration))
        ]))
      ],
    );
  }
}

class _HoldsAndSets extends StatelessWidget {
  _HoldsAndSets({Key key, @required this.sets, @required this.holdCount})
      : super(key: key);

  final int sets;
  final int holdCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
            child: Column(children: <Widget>[
          Text(
            'holds',
            style: styles.Staatliches.xsBlack,
          ),
          Divider(
            height: styles.Measurements.xs,
          ),
          Text(
            holdCount.toString(),
            textAlign: TextAlign.center,
            style: styles.Lato.xsGray,
          )
        ])),
        Expanded(
            child: Column(children: <Widget>[
          Text(
            'sets',
            style: styles.Staatliches.xsBlack,
          ),
          Divider(
            height: styles.Measurements.xs,
          ),
          Text(
            sets.toString(),
            textAlign: TextAlign.center,
            style: styles.Lato.xsGray,
          )
        ])),
      ],
    );
  }
}

class _AvHangTimeAndAddedWeight extends StatelessWidget {
  _AvHangTimeAndAddedWeight(
      {Key key,
      @required this.averageAddedWeight,
      @required this.averageHangTime,
      @required this.unit})
      : super(key: key);

  final int averageHangTime;
  final double averageAddedWeight;
  final Unit unit;

  @override
  Widget build(BuildContext context) {
    final String _unit = unit == Unit.metric ? 'kg' : 'lb';
    final String _avAddedWeight = '$averageAddedWeight $_unit';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
            child: Column(children: <Widget>[
          Text(
            'av. hang time',
            style: styles.Staatliches.xsBlack,
          ),
          Divider(
            height: styles.Measurements.xs,
          ),
          _WorkoutDuration(seconds: averageHangTime)
        ])),
        Expanded(
            child: Column(children: <Widget>[
          Text(
            'av. added weight',
            style: styles.Staatliches.xsBlack,
          ),
          Divider(
            height: styles.Measurements.xs,
          ),
          Text(
            _avAddedWeight,
            textAlign: TextAlign.center,
            style: styles.Lato.xsGray,
          )
        ])),
      ],
    );
  }
}

class _DifficultyAndPerceivedExertion extends StatelessWidget {
  _DifficultyAndPerceivedExertion(
      {Key key,
      @required this.difficulty,
      @required this.difficultyColor,
      @required this.perceivedExertion,
      @required this.perceivedExertionColor})
      : super(key: key);

  final Color difficultyColor;
  final int difficulty;
  final int perceivedExertion;
  final Color perceivedExertionColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
            child: Column(children: <Widget>[
          Text(
            'difficulty',
            style: styles.Staatliches.xsBlack,
          ),
          Divider(
            height: styles.Measurements.xs,
          ),
          Difficulty(
              difficulty: difficulty.toString(),
              difficultyColor: difficultyColor,
              width: styles.Measurements.xl,
              height: styles.Measurements.xl)
        ])),
        Expanded(
            child: Column(children: <Widget>[
          Text(
            'perceived exertion',
            style: styles.Staatliches.xsBlack,
          ),
          Divider(
            height: styles.Measurements.xs,
          ),
          Difficulty(
              difficulty: perceivedExertion.toString(),
              difficultyColor: difficultyColor,
              width: styles.Measurements.xl,
              height: styles.Measurements.xl)
        ])),
      ],
    );
  }
}

class _CompletedAtAndTotalDuration extends StatelessWidget {
  _CompletedAtAndTotalDuration(
      {Key key, @required this.completedLocalDate, @required this.duration})
      : super(key: key);

  final DateTime completedLocalDate;
  final int duration;

  @override
  Widget build(BuildContext context) {
    final int hour = completedLocalDate.hour;
    final int minutes = completedLocalDate.minute;
    final String timeStamp = '$hour:$minutes';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
            child: Column(children: <Widget>[
          Text(
            'completed at',
            style: styles.Staatliches.xsBlack,
          ),
          Divider(
            height: styles.Measurements.xs,
          ),
          Text(
            '${timeStamp}h',
            textAlign: TextAlign.center,
            style: styles.Lato.xsGray,
          )
        ])),
        Expanded(
            child: Column(children: <Widget>[
          Text(
            'total duration',
            style: styles.Staatliches.xsBlack,
          ),
          Divider(
            height: styles.Measurements.xs,
          ),
          _WorkoutDuration(
            seconds: duration,
          )
        ])),
      ],
    );
  }
}

double _calculateAverageAddedWeight(Workout workout) {
  final List<double> weights = workout.holds.map((w) => w.addedWeight).toList();
  final double total = weights.fold(0, (a, b) => a + b);
  final double average = total / weights.length;
  return double.parse(average.toStringAsFixed(1));
}

int _calculateAverageHangTime(Workout workout) {
  final List<int> hangSeconds = workout.holds.map((w) => w.hangTime).toList();
  final double total = hangSeconds.fold(0, (a, b) => a + b);
  return total ~/ hangSeconds.length;
}
