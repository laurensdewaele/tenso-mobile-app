import 'package:flutter/cupertino.dart' hide Icon;

import 'package:app/helpers/average_added_weight.dart';
import 'package:app/helpers/average_hang_time.dart';
import 'package:app/models/weight_unit.dart';
import 'package:app/models/workout.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:app/widgets/button.dart';
import 'package:app/widgets/color_square.dart';
import 'package:app/widgets/icon.dart';
import 'package:app/widgets/divider.dart';
import 'package:app/widgets/workout_overview/display_duration_seconds.dart';
import 'package:app/widgets/workout_overview/expanded_content_tile.dart';

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
              title: 'total duration',
              content: DisplayDurationSeconds(seconds: workout.duration),
              contentContainerHeight: styles.Measurements.xl,
            ),
          ],
        ),
        Divider(height: styles.Measurements.m),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ExpandedContentTile(
              title: 'av. hang time',
              content: DisplayDurationSeconds(
                  seconds: calculateAverageHangTime(workout)),
            ),
            ExpandedContentTile(
                title: 'av. added weight',
                content: Text(
                  '${calculateAverageAddedWeight(workout)} ${workout.weightUnit == WeightUnit.metric ? 'kg' : 'lbs'}',
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
