import 'package:flutter/cupertino.dart' hide Icon;
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/widgets/card.dart';
import 'package:tenso_app/widgets/color_square.dart';
import 'package:tenso_app/widgets/divider.dart';
import 'package:tenso_app/widgets/icons.dart' as icons;

class SelectedFilter {
  final String workoutName;
  final Color labelColor;

  const SelectedFilter({
    this.workoutName,
    this.labelColor,
  });
}

class StatsFilter extends StatelessWidget {
  const StatsFilter({
    @required this.handleTap,
    @required this.selectedFilter,
  });

  final VoidCallback handleTap;
  final SelectedFilter selectedFilter;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double _kLeftRightContainerWidth = 57;

      String _workoutName = selectedFilter.workoutName;
      final Color _labelColor = selectedFilter.labelColor;

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
                    if (_workoutName == null && _labelColor == null)
                      Text(
                        'none',
                        style: styles.Staatliches.mBlack,
                      ),
                    if (_workoutName != null)
                      Text(_workoutName,
                          style: styles.Staatliches.mBlack,
                          overflow: TextOverflow.ellipsis),
                    if (_labelColor != null && _workoutName != null)
                      Divider(width: styles.Measurements.xs),
                    if (_labelColor != null)
                      ColorSquare(
                        color: _labelColor,
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
