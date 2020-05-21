import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/button.dart';
import 'package:app/widgets/color_square.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/icons.dart' as icons;
import 'package:app/widgets/workout_overview/display_duration_seconds.dart';
import 'package:app/widgets/workout_overview/expanded_content_tile.dart';
import 'package:flutter/cupertino.dart' hide Icon;

class WorkoutExpandedContent extends StatelessWidget {
  WorkoutExpandedContent(
      {Key key, @required this.handleStart, @required this.workout})
      : super(key: key);

  final VoidCallback handleStart;
  final Workout workout;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(height: styles.Measurements.l),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ExpandedContentTile(
              title: 'label',
              content: ColorSquare(
                  color: workout.labelColor,
                  width: styles.Measurements.xl,
                  height: styles.Measurements.xl),
              contentContainerHeight: styles.Measurements.xl,
            ),
            ExpandedContentTile(
              title: 'time under tension',
              content:
                  DisplayDurationSeconds(seconds: workout.timeUnderTension),
              contentContainerHeight: styles.Measurements.xl,
            ),
          ],
        ),
        Divider(height: styles.Measurements.m),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            if (workout.countdownRestTimer == true)
              ExpandedContentTile(
                title: 'total rest time',
                content: DisplayDurationSeconds(seconds: workout.totalRestTime),
              ),
            if (workout.countdownRestTimer == false)
              ExpandedContentTile(
                title: 'total rest time',
                content: Text(
                  'variable',
                  textAlign: TextAlign.center,
                  style: styles.Lato.xsGray,
                ),
              ),
            ExpandedContentTile(
                title: 'av. added weight',
                content: Text(
                  '${workout.averageAddedWeight} ${workout.weightUnit.unitText}',
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
              title: 'holds',
              content: Text(
                workout.holdCount.toString(),
                textAlign: TextAlign.center,
                style: styles.Lato.xsGray,
              ),
            ),
            ExpandedContentTile(
                title: 'sets',
                content: Text(
                  workout.sets.toString(),
                  textAlign: TextAlign.center,
                  style: styles.Lato.xsGray,
                )),
          ],
        ),
        Divider(height: styles.Measurements.m),
        Container(
            width: 175.0,
            child: Button(
              text: 'start',
              handleTap: handleStart,
              leadingIcon: icons.playIconWhiteL,
            )),
        Divider(height: styles.Measurements.m),
      ],
    );
  }
}
