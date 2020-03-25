import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/models/completed_workout.dart';
import 'package:app/models/temp_unit.dart';
import 'package:app/models/weight_unit.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/difficulty.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/workout_overview/display_duration_seconds.dart';
import 'package:app/widgets/workout_overview/expanded_content_tile.dart';

class CompletedExpandedWorkoutContent extends StatelessWidget {
  CompletedExpandedWorkoutContent({Key key, @required this.completedWorkout})
      : super(key: key);

  final CompletedWorkout completedWorkout;

  @override
  Widget build(BuildContext context) {
    // We have 3 variables that could be null
    // Humidity
    // Body weight
    // Temp
    // I don't want empty spots in rows, how?
    // Make an array of the 3
    final List<Widget> _possibleNullContent = [
      if (completedWorkout.humidity != null)
        ExpandedContentTile(
            title: 'humidity',
            content: Text(
              '${completedWorkout.humidity}%',
              textAlign: TextAlign.center,
              style: styles.Lato.xsGray,
            )),
      if (completedWorkout.bodyWeight != null)
        ExpandedContentTile(
          title: 'body weight',
          content: Text(
            '${completedWorkout.bodyWeight} ${completedWorkout.workout.weightUnit == WeightUnit.metric ? 'kg' : 'lbs'}',
            textAlign: TextAlign.center,
            style: styles.Lato.xsGray,
          ),
        ),
      if (completedWorkout.temperature != null)
        ExpandedContentTile(
            title: 'temperature',
            content: Text(
              '${completedWorkout.temperature}° ${completedWorkout.tempUnit == TempUnit.celsius ? 'C' : 'F'}',
              textAlign: TextAlign.center,
              style: styles.Lato.xsGray,
            )),
    ];

    return Column(
      children: <Widget>[
        Divider(height: styles.Measurements.l),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ExpandedContentTile(
              title: 'difficulty',
              content: Difficulty(
                  difficulty: completedWorkout.workout.difficulty.toString(),
                  difficultyColor: completedWorkout.workout.difficultyColor,
                  width: styles.Measurements.xl,
                  height: styles.Measurements.xl),
              contentContainerHeight: styles.Measurements.xl,
            ),
            ExpandedContentTile(
              title: 'perceived exertion',
              content: Difficulty(
                  difficulty: completedWorkout.perceivedExertion.toString(),
                  difficultyColor: completedWorkout.perceivedExertionColor,
                  width: styles.Measurements.xl,
                  height: styles.Measurements.xl),
              contentContainerHeight: styles.Measurements.xl,
            ),
          ],
        ),
        Divider(height: styles.Measurements.m),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ExpandedContentTile(
                title: 'completed at',
                content: Text(
                  '${completedWorkout.completedLocalDate.hour}:${completedWorkout.completedLocalDate.minute} h',
                  textAlign: TextAlign.center,
                  style: styles.Lato.xsGray,
                )),
            ExpandedContentTile(
                title: 'completion',
                content: Text(
                  '90%',
                  textAlign: TextAlign.center,
                  style: styles.Lato.xsGray,
                )),
          ],
        ),
        Divider(height: styles.Measurements.m),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ExpandedContentTile(
              title: 'effective time hung',
              content: DisplayDurationSeconds(
                seconds: 240,
              ),
            ),
            if (_possibleNullContent.length > 0) _possibleNullContent[0]
          ],
        ),
        Divider(height: styles.Measurements.m),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            if (_possibleNullContent.length > 1) _possibleNullContent[1],
            if (_possibleNullContent.length > 2) _possibleNullContent[2]
          ],
        ),
        if (completedWorkout.comments != null)
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Divider(height: styles.Measurements.m),
              Text(
                'comments',
                style: styles.Staatliches.xsBlack,
              ),
              Text(
                completedWorkout.comments,
                style: styles.Lato.xsGray,
              )
            ],
          ),
        Divider(height: styles.Measurements.m),
      ],
    );
  }
}
