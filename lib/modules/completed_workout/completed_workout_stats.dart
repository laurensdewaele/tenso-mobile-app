import 'package:flutter/cupertino.dart' hide Icon;
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/modules/common/color_square.dart';
import 'package:tenso_app/modules/workout_overview/display_duration_seconds.dart';
import 'package:tenso_app/modules/workout_overview/expanded_content_tile.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

class CompletedWorkoutStats extends StatelessWidget {
  final CompletedWorkout completedWorkout;

  const CompletedWorkoutStats({
    @required this.completedWorkout,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      childAspectRatio: 1.7,
      children: <Widget>[
        ExpandedContentTile(
          title: 'label',
          content: ColorSquare(
              color: completedWorkout.workout.label.color,
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
        ExpandedContentTile(
          title: 'effective time hung',
          content: DisplayDurationSeconds(
            seconds:
                (completedWorkout.history.timerUnderTensionMs / 1000).round(),
          ),
        ),
        ExpandedContentTile(
          title: 'effective rest time',
          content: DisplayDurationSeconds(
            seconds: (completedWorkout.history.totalRestTimeMs / 1000).round(),
          ),
        ),
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
        if (completedWorkout.history.averageAddedWeight != 0)
          ExpandedContentTile(
              title: 'av. added weight',
              content: Text(
                '${completedWorkout.history.averageAddedWeight} ${completedWorkout.workout.weightSystem.unit}',
                textAlign: TextAlign.center,
                style: styles.Lato.xsGray,
              )),
        if (completedWorkout.averageAddedWeightInBodyWeightPercentage != null)
          ExpandedContentTile(
              title: 'av. added weight bodyweight %',
              content: Text(
                '${completedWorkout.averageAddedWeightInBodyWeightPercentage} %',
                textAlign: TextAlign.center,
                style: styles.Lato.xsGray,
              )),
      ],
    );
  }
}
