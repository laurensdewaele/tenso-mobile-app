import 'package:flutter/cupertino.dart' hide Icon;
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/modules/common/card.dart';
import 'package:tenso_app/modules/common/color_square.dart';
import 'package:tenso_app/modules/common/divider.dart';
import 'package:tenso_app/modules/common/icons.dart' as icons;
import 'package:tenso_app/styles/styles.dart' as styles;

class StatsFilterCard extends StatelessWidget {
  const StatsFilterCard(
      {@required this.handleTap, this.filteredLabel, this.filteredWorkout});

  final VoidCallback handleTap;
  final Label filteredLabel;
  final Workout filteredWorkout;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double _kLeftRightContainerWidth = 57;

      String _workoutName = filteredWorkout?.name;

      if (_workoutName != null && _workoutName.length > 21) {
        _workoutName = _workoutName.substring(0, 21);
        _workoutName = '$_workoutName...';
      }

      return GestureDetector(
        onTap: handleTap,
        child: Card(
          padding: EdgeInsets.symmetric(
            horizontal: styles.Measurements.xs,
            vertical: styles.Measurements.xs,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: _kLeftRightContainerWidth,
                child: Row(
                  children: [
                    Text(
                      'filter:',
                      style: styles.Staatliches.mBlack,
                    ),
                    Divider(
                      width: styles.Measurements.xs,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (filteredLabel == null && filteredWorkout == null)
                      Text(
                        'none',
                        style: styles.Staatliches.mBlack,
                      ),
                    if (filteredWorkout != null)
                      Text(_workoutName,
                          style: styles.Staatliches.mBlack,
                          overflow: TextOverflow.ellipsis),
                    if (filteredWorkout != null)
                      Divider(width: styles.Measurements.xs),
                    if (filteredWorkout != null)
                      ColorSquare(
                        color: filteredWorkout.label.color,
                        width: styles.Measurements.m,
                        height: styles.Measurements.m,
                      ),
                    if (filteredLabel != null)
                      ColorSquare(
                        color: filteredLabel.color,
                        width: styles.Measurements.m,
                        height: styles.Measurements.m,
                      ),
                  ],
                ),
              ),
              Container(
                  width: _kLeftRightContainerWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Divider(
                        width: styles.Measurements.xs,
                      ),
                      icons.forwardIconBlackL,
                    ],
                  ))
            ],
          ),
        ),
      );
    });
  }
}
