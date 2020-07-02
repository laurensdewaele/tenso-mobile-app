import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/calendar/logs_overview.dart';
import 'package:app/widgets/color_square.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/workout_overview/display_duration_seconds.dart';
import 'package:app/widgets/workout_overview/expanded_content_tile.dart';
import 'package:flutter/cupertino.dart' hide Icon;

class CompletedExpandedWorkoutContent extends StatelessWidget {
  CompletedExpandedWorkoutContent({Key key, @required this.completedWorkout})
      : super(key: key);

  final CompletedWorkout completedWorkout;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _possibleNullContent = [
      if (completedWorkout.humidity != null)
        ExpandedContentTile(
            title: 'humidity',
            content: Text(
              '${completedWorkout.humidity} %',
              textAlign: TextAlign.center,
              style: styles.Lato.xsGray,
            )),
      if (completedWorkout.bodyWeight != null)
        ExpandedContentTile(
          title: 'body weight',
          content: Text(
            '${completedWorkout.bodyWeight} ${completedWorkout.workout.weightSystem.unit}',
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
              title: 'label',
              content: ColorSquare(
                  color: completedWorkout.workout.labelColor,
                  width: styles.Measurements.xl,
                  height: styles.Measurements.xl),
              contentContainerHeight: styles.Measurements.xl,
            ),
            ExpandedContentTile(
              title: 'perceived exertion',
              content: ColorSquare(
                  text: completedWorkout.perceivedExertion.toString(),
                  color: completedWorkout.perceivedExertionColor,
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
                  '${completedWorkout.history.completedPercentage}%',
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
                seconds: (completedWorkout.history.timerUnderTensionMs / 1000)
                    .round(),
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
                textAlign: TextAlign.center,
                style: styles.Lato.xsGray,
              )
            ],
          ),
        Divider(height: styles.Measurements.m),
        LogsOverview(
          weightUnit: completedWorkout.workout.weightSystem.unit,
          groups: completedWorkout.workout.groups.toList(),
          logs: completedWorkout.history.sequenceTimerLogs.toList(),
        )
      ],
    );
  }
}
