import 'package:flutter/cupertino.dart' hide Icon;
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/modules/common/button.dart';
import 'package:tenso_app/modules/common/color_square.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/modules/common/icons.dart' as icons;
import 'package:tenso_app/modules/horizontal_group_overview/horizonal_group_overview_with_indicator.dart';
import 'package:tenso_app/modules/workout_overview/display_duration_seconds.dart';
import 'package:tenso_app/modules/workout_overview/expanded_content_tile.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

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
                  color: workout.label.color,
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
            if (workout.totalRestTime != null)
              ExpandedContentTile(
                title: 'total rest',
                content: DisplayDurationSeconds(seconds: workout.totalRestTime),
                contentContainerHeight: styles.Measurements.xl,
              ),
            if (workout.totalRestTime == null)
              ExpandedContentTile(
                title: 'total rest',
                content: Center(
                  child: Text(
                    'variable',
                    textAlign: TextAlign.center,
                    style: styles.Lato.xsGray,
                  ),
                ),
                contentContainerHeight: styles.Measurements.xl,
              ),
          ],
        ),
        Divider(height: styles.Measurements.l),
        HorizontalGroupOverviewWithIndicator(groups: workout.groups.toList()),
        Divider(height: styles.Measurements.xxl),
        Container(
            width: 175.0,
            child: Button(
              text: 'start',
              handleTap: handleStart,
              leadingIcon: icons.playIconWhiteL,
            )),
        Divider(height: styles.Measurements.xs),
      ],
    );
  }
}
